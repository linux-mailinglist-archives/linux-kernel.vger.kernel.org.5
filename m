Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39707BCA7C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbjJGXj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbjJGXjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:39:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E8D8;
        Sat,  7 Oct 2023 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696721980; x=1697326780; i=w_armin@gmx.de;
 bh=NBubrQ6eNN+2+jfjz7U83zs3HdPq44DR/srwfNy27VY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XL6aUvdWcopw5Lmlddrfe81Sh75bfbf13YroMr8+gBYDhQrg1WwaI+QK6wQf/Yscx4GF1ZXWgGY
 P5FVFuhcyV5XsXg2EeWANEL0qpd8LSoFVGp6YAfMUIvSGgNqv7p6mBMetisVS6kik8Xk2qIxDUFKL
 q9/rps9jZC4AGCem2h2PcWeeT719EGBj/QSXwGdSkj1ktVqOw/YDh8ZDPA95Lr/qG3jMJ7T49vLLd
 6gAhKSZvt1e3cn4FOnih34De5SQVR1M7mHrjBlWW2Jdit9z8cZaYekwhRg8whP7AOAF+Nh0YbZQav
 IimhMqXqTjiTZsCt5tGMbKOhKW5UzE2ZVYWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MHXBj-1qka3J0BSz-00DU1w; Sun, 08 Oct 2023 01:39:40 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] platform/x86: wmi: Update MAINTAINERS entry
Date:   Sun,  8 Oct 2023 01:39:28 +0200
Message-Id: <20231007233933.72121-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007233933.72121-1-W_Armin@gmx.de>
References: <20231007233933.72121-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jRDdSB3B5OmOxtX/f6bZH9Jl8ng/DMIkdyu5a7gQojk8OxLmb8I
 i5Csx0cyB4JaAn6lgmjFcuVcPSO9qTuXx6tu8jWeMfiCzaZokzaejHDKzgln4JNCKTkHfg4
 pV0padRALK2V8nD2kft1RJZy5OpSzNhBDpKRu6nWxj7li6Cc5CcLeYKUK6JOf4hUvlEpm8q
 s5xr8z+OzlHeOMhnhINpQ==
UI-OutboundReport: notjunk:1;M01:P0:6L+gLwVLfds=;gBBWyOQsnQXWi87LoTDIf6FPTrY
 WzdODYpvHhOtg1sqcBRjhmyUH2Dinp268cCmLLDD8uwpDsJuDzJLQBGcvy/MiLusaLoiY+/bJ
 V23EpZ8N6eKyQGbHgAOabmx++m4XTIQr6bUUkAwtXBY4liV/X89hL0lCppBaqpqNmJJyYFAPt
 RVmVszZO02v0YOs5K8sxaFzM3fqwdk+ydW5Hg9H3NfK2orEaTk0YkmFeGAaL0c29fiJXCtW7b
 RGrchgDsdmRGVb1X7KCTqm81NiAPI95c1fkASLGhEumnROkidYGPH57aVDGxiXT9OD8RQY4wS
 Ee+wT7Xd55RYltd6td1lL5KPcjbF3CM8mkWrhNvl2WySMf8UhcAPn50h1PNewhCQbuCO3iskc
 lbzrSI31Ul1FoBTmhc3IqtAJgKiMDUxANA8OmSzM/DJZpuxUJsQd6MCMAsN1gZ7kEABykwOK0
 7AjHJMwPy4/kAZPFyeVpZllC2QLXroZAd0C2EdrYiwi7WA4Xc9Con2It3CijQ2viuZcrlMDqy
 0lMYomXcRNE9yMdS5vEies/oAy3bbKxXuihCNLrk6uiE78/RA1/xvQZNWwdvH2jKHe/hxDtbs
 6WAksml0XcLgxBN5QdhirUo4mIugpFVo1kRFyM8rBHH5057dAdxHoi24DzuO5MRSlufeYoyai
 4AZrPILkf3nqlaUPA8LkY2ELKqzVBl5KbJp4JKN3u1Xg56vZ9TC+aiCZSz/WFIGjbvMy2gzEW
 XaypnUBfqd+K7jpXxFmRjYXjuqVbt+86xK/pLGP39Z+2ODffPUKqFrXpwVfkd4CsEZ4b9ou4H
 sETqBzZmMbMPRjYqu4dyW3WlDAYz670iSD6xIgHEnK5TXwjiiqRDWRundgtldcq11YlvoPqK1
 xk+QCZjhnPcehjiXv+acsA0VdxAfNM686EmD5QXC2G/WIocpujQnI1qnXHepAAl8bAc780Fjc
 hhl3bSAngaMBpVuFljwlWWVbkfs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2011, the WMI subsystem is marked as orphaned,
which means that a important part of platform support
for modern notebooks and even desktops is receiving
not enough maintenance.
So i decided to take over the maintenance of the WMI
subsystem.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..ba309dea6e4e 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -378,8 +378,9 @@ F:	drivers/acpi/viot.c
 F:	include/linux/acpi_viot.h

 ACPI WMI DRIVER
+M:	Armin Wolf <W_Armin@gmx.de>
 L:	platform-driver-x86@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	Documentation/driver-api/wmi.rst
 F:	Documentation/wmi/
 F:	drivers/platform/x86/wmi.c
=2D-
2.39.2

