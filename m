Return-Path: <linux-kernel+bounces-65917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD68553B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC341F2ACCE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B225A13DBB7;
	Wed, 14 Feb 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j7AHgBTX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B613DBA1;
	Wed, 14 Feb 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941410; cv=none; b=M+CIqvJhZPwQkKLY3F1hG5i/fNSusAu1ijddcF1yCio3vU6ZA0fV4quwEritmTlrQHxB8trypME5PaAGAN2u55TSGu4JzTVQtYQgp692IyQxtJnYkNaQ6Fcyg8KvJ9obeYDLXzSCCt9TO3O3v7pzKaNniHwYLbjePqehgsPEmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941410; c=relaxed/simple;
	bh=sJ2O1TysiYXzPmk/VbHIkh8RUm4JPVEySfwgSUfKEh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lIBu3y3yd+euFe1r2SNcCsQhHn58gDBmGy0s99v+7f/SpZ2iNP8YtsrpL9m4kf7uje9FaYy4uSLizVgKjn1Gm3kwUGOThP8fNox72Fl2DfDeF+iMySnYUjenKFXPmh1DfjrE2lB/rgShDApH5lEtOT1l0L3/UjGMsfny2S9JJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j7AHgBTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A030EC433F1;
	Wed, 14 Feb 2024 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707941410;
	bh=sJ2O1TysiYXzPmk/VbHIkh8RUm4JPVEySfwgSUfKEh0=;
	h=From:Date:Subject:To:Cc:From;
	b=j7AHgBTX0a6tWdO0KqlSsaN0z8fLxw5cZyRPqJz7cPtbbUE3qMx4FNf6jZlLsOTb4
	 aWUnF4DEi3HFoIgwlQwlDUWIGIEJHUy3tZT4T8H7C8/fL+U5hSOJ/zBQy3urQLuN7p
	 0dx5qw4w+wC4Lskk26kvmPxZ7teYnwQtJJdfHWxk=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Wed, 14 Feb 2024 15:09:53 -0500
Subject: [PATCH] Documentation: update mailing list addresses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-lf-org-list-migration-v1-1-ef1eab4b1543@linuxfoundation.org>
X-B4-Tracking: v=1; b=H4sIABAezWUC/x3MPQqAMAxA4atIZgNN66BeRRyKpjXgH6mIULy7x
 fEN38uQWIUT9FUG5VuSHHsJqiuYFr9HRplLgzW2MZYaXAMeGnGVdOEmUf1VBJrQUqDOk3MOij2
 Vgzz/dxjf9wN53vMhZwAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Theodore Ts'o <tytso@mit.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Carlos Bilbao <carlos.bilbao@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 tech-board-discuss@lists.linux.dev, workflows@vger.kernel.org, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.13-dev-b7ccd
X-Developer-Signature: v=1; a=openpgp-sha256; l=6088;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=sJ2O1TysiYXzPmk/VbHIkh8RUm4JPVEySfwgSUfKEh0=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGFLPyimUR0QaHSortdecm9mqZ9h3c++/w8zNOhtuSx5i8
 56jxcHSUcrCIMbFICumyFK2L3ZTUOFDD7n0HlOYOaxMIEMYuDgFYCIFDgz/DFWyTx47vfDkThVH
 W8Olfzhmx6qu5Aq/sHLvg03O/z2TPRkZ/uzpKCwS+7r98cYj/Me5H0iveB3hXq90/72wYtSCAP9
 jLAA=
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

The mailman2 server running on lists.linuxfoundation.org will be shut
down in very imminent future. Update all instances of obsolete list
addresses throughout the tree with their new destinations.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
Jon, I am sending this primarily to linux-doc, since most of the changes
are in Documentation/* and only a handful in MAINTAINERS. I think it
makes most sense to bubble this up via the docs subsystem.
---
 Documentation/ABI/testing/sysfs-bus-vdpa                       | 10 +++++-----
 Documentation/networking/bridge.rst                            |  2 +-
 Documentation/process/researcher-guidelines.rst                |  2 +-
 .../translations/sp_SP/process/researcher-guidelines.rst       |  2 +-
 MAINTAINERS                                                    |  6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-vdpa b/Documentation/ABI/testing/sysfs-bus-vdpa
index 4da53878bff6..2c833b5163f2 100644
--- a/Documentation/ABI/testing/sysfs-bus-vdpa
+++ b/Documentation/ABI/testing/sysfs-bus-vdpa
@@ -1,6 +1,6 @@
 What:		/sys/bus/vdpa/drivers_autoprobe
 Date:		March 2020
-Contact:	virtualization@lists.linux-foundation.org
+Contact:	virtualization@lists.linux.dev
 Description:
 		This file determines whether new devices are immediately bound
 		to a driver after the creation. It initially contains 1, which
@@ -12,7 +12,7 @@ Description:
 
 What:		/sys/bus/vdpa/driver_probe
 Date:		March 2020
-Contact:	virtualization@lists.linux-foundation.org
+Contact:	virtualization@lists.linux.dev
 Description:
 		Writing a device name to this file will cause the kernel binds
 		devices to a compatible driver.
@@ -22,7 +22,7 @@ Description:
 
 What:		/sys/bus/vdpa/drivers/.../bind
 Date:		March 2020
-Contact:	virtualization@lists.linux-foundation.org
+Contact:	virtualization@lists.linux.dev
 Description:
 		Writing a device name to this file will cause the driver to
 		attempt to bind to the device. This is useful for overriding
@@ -30,7 +30,7 @@ Description:
 
 What:		/sys/bus/vdpa/drivers/.../unbind
 Date:		March 2020
-Contact:	virtualization@lists.linux-foundation.org
+Contact:	virtualization@lists.linux.dev
 Description:
 		Writing a device name to this file will cause the driver to
 		attempt to unbind from the device. This may be useful when
@@ -38,7 +38,7 @@ Description:
 
 What:		/sys/bus/vdpa/devices/.../driver_override
 Date:		November 2021
-Contact:	virtualization@lists.linux-foundation.org
+Contact:	virtualization@lists.linux.dev
 Description:
 		This file allows the driver for a device to be specified.
 		When specified, only a driver with a name matching the value
diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index ba14e7b07869..ef8b73e157b2 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -324,7 +324,7 @@ Contact Info
 The code is currently maintained by Roopa Prabhu <roopa@nvidia.com> and
 Nikolay Aleksandrov <razor@blackwall.org>. Bridge bugs and enhancements
 are discussed on the linux-netdev mailing list netdev@vger.kernel.org and
-bridge@lists.linux-foundation.org.
+bridge@lists.linux.dev.
 
 The list is open to anyone interested: http://vger.kernel.org/vger-lists.html#netdev
 
diff --git a/Documentation/process/researcher-guidelines.rst b/Documentation/process/researcher-guidelines.rst
index d159cd4f5e5b..beb484c5965d 100644
--- a/Documentation/process/researcher-guidelines.rst
+++ b/Documentation/process/researcher-guidelines.rst
@@ -167,4 +167,4 @@ If no one can be found to internally review patches and you need
 help finding such a person, or if you have any other questions
 related to this document and the developer community's expectations,
 please reach out to the private Technical Advisory Board mailing list:
-<tech-board@lists.linux-foundation.org>.
+<tech-board@groups.linuxfoundation.org>.
diff --git a/Documentation/translations/sp_SP/process/researcher-guidelines.rst b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
index 462b3290b7b8..deccc908a68d 100644
--- a/Documentation/translations/sp_SP/process/researcher-guidelines.rst
+++ b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
@@ -147,4 +147,4 @@ Si no se puede encontrar a nadie para revisar internamente los parches y necesit
 ayuda para encontrar a esa persona, o si tiene alguna otra pregunta relacionada
 con este documento y las expectativas de la comunidad de desarrolladores, por
 favor contacte con la lista de correo privada Technical Advisory Board:
-<tech-board@lists.linux-foundation.org>.
+<tech-board@groups.linuxfoundation.org>.
diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..ffdfb311349f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14010,7 +14010,7 @@ F:	include/uapi/rdma/mlx5-abi.h
 
 MELLANOX MLX5 VDPA DRIVER
 M:	Dragos Tatulea <dtatulea@nvidia.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Supported
 F:	drivers/vdpa/mlx5/
 
@@ -21519,7 +21519,7 @@ F:	tools/testing/selftests/drivers/net/team/
 TECHNICAL ADVISORY BOARD PROCESS DOCS
 M:	"Theodore Ts'o" <tytso@mit.edu>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-L:	tech-board-discuss@lists.linux-foundation.org
+L:	tech-board-discuss@lists.linux.dev
 S:	Maintained
 F:	Documentation/process/contribution-maturity-model.rst
 F:	Documentation/process/researcher-guidelines.rst
@@ -23078,7 +23078,7 @@ F:	drivers/vfio/pci/mlx5/
 VFIO VIRTIO PCI DRIVER
 M:	Yishai Hadas <yishaih@nvidia.com>
 L:	kvm@vger.kernel.org
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/vfio/pci/virtio
 

---
base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
change-id: 20240214-lf-org-list-migration-0f81f19a1333

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>


