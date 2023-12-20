Return-Path: <linux-kernel+bounces-6998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D681A05B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742751C22672
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5622936B1F;
	Wed, 20 Dec 2023 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JQBnorrg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8524038DE0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703080547; x=1703339747;
	bh=rqYswHeurWEqq+h+3OUgCBIjUPcIMyCOBd+3HdDNPTs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JQBnorrgB6ReVA6MrULm2djTBYNk9oQR73QvtoBwU1FqsOxvAh5r3nmDgnw8MjxAu
	 4tKlRaBp+dMBaQMqcSkZ86oSz3OsodHYgOJdEa4C46l/v0U4CgkVfEHFG7xEcET5bd
	 sG5BRje7+E7HCF4gCQzID9C+vB801n6/v0USpYJqz/YN6/kOOf7LakVa2lIwq9PJWm
	 hDtFdSDsz8bGjCms67x4sSESkEV4hErSdkqfx2niWLcLsPGfRA/kI1YE7k1ajMcWqh
	 1nBWlwnb3IY4oSB+IFshhYE9sfRuWH5XOnvQqSIAhiuvjKc5jvE7PiziKvjo0OBkAY
	 PGGvePQCl1N4Q==
Date: Wed, 20 Dec 2023 13:55:27 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: I have the latest and greatest Linux Kernel 6.6.7 installed on my refurbished Aftershock gaming laptop after installing Arch Linux on 19 Dec 2023 Tue
Message-ID: <mRejxPdoL9CnXaSysWPg-tNQ2QaQa2LNbtQFWlQv4NVzG2fBSM8Lb_gPKHJTYHiAxerATFYf2aE-ibE8JUtACknsOzzi1goPrUNV5MYIWnI=@protonmail.com>
Feedback-ID: 39510961:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: I have the latest and greatest Linux Kernel 6.6.7 installed on my =
refurbished Aftershock gaming laptop after installing Arch Linux on 19 Dec =
2023 Tue

Good day from Singapore,

I have the latest and greatest Linux Kernel 6.6.7 installed on my refurbish=
ed Aftershock gaming laptop after installing Arch Linux on 19 Dec 2023 Tue =
in the evening.

Please refer to the following post at Arch Linux General Discussion mailing=
 list.

Post: [Part 1] These are the guides I have followed to install Arch Linux w=
ith Linux Kernel 6.6.7 and GNOME on my refurbished Aftershock gaming laptop
Link: https://lists.archlinux.org/hyperkitty/list/arch-general@lists.archli=
nux.org/thread/LQTBZYXA26ZTMDZ2IXG4NHNOMDUC6RL3/

You will be able to install the latest and greatest Linux Kernel 6.6.7 by f=
ollowing the guides mentioned in the above mailing list post. I chose Arch =
Linux because it is able to offer the latest Linux Kernel package in its re=
pository. No other Linux distro/distribution is able to offer the latest Li=
nux Kernel for installation immediately after it has been released.

Arch Linux can only be installed using the command line. There is no GUI in=
staller at all to make the installation speedy and efficient. Fortunately, =
I have good understanding of Linux basics and am quite familiar with the Li=
nux command line. I can say I have 18 years of experience with Linux beginn=
ing in the year 2005.

Installing Arch Linux using the command line without a GUI installer can be=
 very very TEDIOUS and very very TIME CONSUMING. But you will get a sense o=
f satisfaction after installing it successfully.

To recap, I have started installing Arch Linux on my refurbished Aftershock=
 gaming laptop on 19 Dec 2023 Tue at 9.24 PM at night. I have more or less =
completed installing Arch Linux on 20 Dec 2023 Wed at about 1.00 AM in the =
early morning.

In total, I have spent about 3 hours and 36 minutes installing Arch Linux w=
ith NetworkManager (able to connect to Ethernet and Wi-Fi), X.org X Server =
and GNOME Desktop Environment with Mozilla Firefox and VLC Video Player. I =
am able to play 4K Ultra HD videos inside Arch Linux. I will spend the next=
 few days or next few weeks (when I have time on my hands) to install Googl=
e Chrome web browser and configure the sudoers file in Arch Linux.

If there are bugs in Linux Kernel 6.6.7, I will report them to this mailing=
 list.

My used 2nd hand Aftershock gaming laptop model is MX-15 Elite (N850HK1).

AFTERSHOCK LAPTOP MODEL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Model: N850HK

Product Code: N850HK1

Serial number: NKN850HK1*****5636

Hardware specifications
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

CPU
=3D=3D=3D

Intel Core i7-7700HQ CPU @ 2.80 GHz (7th generation)

RAM
=3D=3D=3D

SYSTEM MEMORY: 640 KB

EXTENDED MEMORY: 8192 MB (DDR4)

VGA
=3D=3D=3D

Intel HD Graphics 630

NVIDIA GeForce GTX 1050 TI

STORAGE
=3D=3D=3D=3D=3D=3D=3D=3D

SATA PORT 0 WDC WDS120G1G0 (120.0 GB) =E2=80=93 Solid State Disk (SSD) for =
installing operating systems

SATA PORT 2 HGST HTS721010 (1000.2 GB or 1 TB) =E2=80=93 HARDDISK, NOT SSD

ME FW VERSION: 11.6.25.1229

MB SERIES: N85_N87,HJ,HJ1,HK1

BIOS VERSION: 1.05.14TASP

KBC/EC FIRMWARE REVISION: 1.05.10

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
GIMP also stands for Government-Induced Medical Problems.
20 Dec 2023 Wednesday 9.54 PM

PS. I have 92 screenshots taken using my vivo V25 Pro 5G mobile phone on Da=
y 1 of installing Arch Linux.




Sent with Proton Mail secure email.

