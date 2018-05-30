# Builtin Management commands
Falcon comes with some management commands. It is also possible to manage services with systemd.

### Object Server
* Start object server: `falcon start object -l /etc/swift/zap.yml`
* Stop object gracefully: `falcon shutdown object`
* Restart object server gracefully: `falcon reload object`
* Stop object server forcely(Don't use this command unless you have to): `falcon stop object`
* Restart object server forcely(Don't use this command unless you have to): `falcon restart object`

### Pack Replicator
* Start pack replicator as daemon: `falcon start pack-replicator`
* Start pack replicator for only one pass: `falcon start pack-replicator -once`
* Only replicate disk sdb: `falcon start pack-replicator -devices sdb`
* Only replicate partition 12: `falcon start pack-replicator -partitions 12`

### Pack Auditor
* Start pack auditor as daemon: `falcon start pack-auditor`
* Start pack auditor for only one pass: `falcon start pack-auditor -once`
* Only audit disk sdb: `falcon start pack-auditor -devices sdb`
* Only audit partition 12: `falcon start pack-auditor -partitions 12`

# Systemd
One advantage to use systemd to manage service is that panic service  could be launched automatically. 

NOTE: Don't use systemd and Falcon's management commands simultaneously. You should adhere to only one way.

We have already provides a [systemctl wrapper example](../../packages/rpm/falcon-object.service) for object server. Wrappers for replicator/auditor are planed to be added later.

* Start object server: `systemctl start falcon-object`
* Stop object server: `systemctl stop falcon-object`
* Restart object server: `systemctl restart falcon-object`
