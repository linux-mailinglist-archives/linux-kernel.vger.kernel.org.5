Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626F3768809
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjG3Uhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjG3Uhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:37:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2210E7A;
        Sun, 30 Jul 2023 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690749452; x=1691354252; i=w_armin@gmx.de;
 bh=0jR/6ZGUONaLBBIaqgMEGUHGN3BM7Rjb+UAgiJ+IqRE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uiT8SkebHzuyxE2Wj7F2q1Fv+PCk4rrYtXt5YhUaMwPzjz+nOpcJ05ixoemfzUbJZYWNDi0
 y8pZQYzxjtfrxLN9+w7TymnWG3KK4r5JU8dqZDJHAHkUGJCT2IychFY6pcmPF9IOR9HP5oqU2
 ow7VDT8f1LkqR+YA+k35YGS7RU/yt7oavCsbz0Jqqc9COoFwO4BA7OztzreyeczWgTJi/FQO8
 5xJ78Pg8I8xYLdfG+PphFA9llE4zH6LgIc5LBTKOry4MHQmGaI6WCWxx+tYujIDrYHP1nPtRI
 SkbX3k4dDqakpr68WIlZJ22VuSbkPBwBWpV3grG260hGlGEn0p1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mqs0R-1q4P5W3rGL-00mrY4; Sun, 30 Jul 2023 22:37:32 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86: wmi-bmof: Update MAINTAINERS entry
Date:   Sun, 30 Jul 2023 22:37:23 +0200
Message-Id: <20230730203723.8882-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730203723.8882-1-W_Armin@gmx.de>
References: <20230730203723.8882-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xt9CJl+6ebAwtAfFCoAdCgLIHVqRaDt6jYAh5iNQOC+yYSfoU65
 /isk5k7Jk2tDpKP5LMsvRbjbczZrgXeKhQ3owfpd/dxw3r/6NhRaTTNxS4G4sp7StounmAL
 GKn6gCaQ/81XwP4yP05LrC3tqupMB7TU/emQ8AqSBjIt7BUK1WpTUeBsbeOYgCDIt0VPQwd
 Qz5JRx5UKwTf/kiDdvnuQ==
UI-OutboundReport: notjunk:1;M01:P0:yuc/2LycNwA=;SvgsGQmsLa8eCAOuObrgVPZQ1Ep
 pynOpaFkCdrU3K+RHsdxOqKb9A+7uJZ6FWxkusyddi8+/tb5qi+1GJu2f6D+xM4zGReuNBf0q
 kpRJNCF8PPaCohudrPzK3Iol4wdEMVk1g4tNypVSQg2NPUrAtHyrU2lz/bOeQmrCsIZXvmt/t
 Kp+voMkmqzajG3xyIcTY2p09NdU9qc6wQrJxgp6MNjvTJuKZ2K6+RQ8BwMtmxs6MJj/nlp+VV
 gvD+irYf60kLmf/P1mLa+rfUwSWVbMdNq2e7R5yxhjzCbN83J0w/N1EzVbXm01ivNZp5Aeg91
 i05ubKV0XL3SJT5VRcs1zICKyGjnuYaeD+J1V7myj7sLYdL9xqGWhe4sOEPUXkC5QM3VzjjnM
 km6UTTQuntKZokyqwZAtOO2t763Mg0A8Ud36CSVHkV2abJJJ4lZpLUDQ3NVEuCJNyIxVO9omR
 LOlsbPjv+ALXtI6ap0SJmcX00FsC8MJ7KONGHL0w5lpSL3LtBjVwNokRHTRuDm7OXat02mWnv
 st5YS+U36ViG9Hf8JzN3MslCm3/mKANqKyHKZhW8WaZczYgkQxs8wX53EVoOgcNTOda4uvwYn
 rTbcILI7xH8mcL4xJJt3pgPJj/JAJPt3IgnbzjI7qEuhb/1ETCDLXdYnMcfVJCSWKJr05nPD3
 2URlvSbZobEp8e93RxrSa+Hdffa/amxdBtPf8fLSXP7/8T3eU06yPi0E0+PzH8Hge3XKfhWhs
 Cr5q/2qVJFSVEDxGa+w7T+phO9ZjudNT17rZsR2GpoRSmbdG8iJ7vMZgBYU6tob/cG3AjycWR
 sfSIHx97PUwislzRa+wUy+iwANJiqsb+A+BlVxxhq5rv0N+M2Bp5/O9zj978V0LN/OqHviHvc
 hdIQRf2Rx8uvfdrKoJ3ec+qARG4mrFHt7zRAxrBcTT/dHciNhwm0V8zN0BVWTJTb9yItNnpXx
 /1jhegRg6pCup1bpQpbAmUi9kF0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WMI Binary MOF driver is important for the development
of modern WMI drivers, i am willing to maintain it.
Also fix the mailing list address.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- Add Thomas Wei=C3=9Fschuh as reviewer
=2D--
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 426d3be71da2..10a182883993 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22954,8 +22954,10 @@ S:	Odd fixes
 F:	drivers/net/wireless/legacy/wl3501*

 WMI BINARY MOF DRIVER
-L:	platform-drivers-x86@vger.kernel.org
-S:	Orphan
+M:	Armin Wolf <W_Armin@gmx.de>
+R:	Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
 F:	Documentation/ABI/stable/sysfs-platform-wmi-bmof
 F:	Documentation/wmi/devices/wmi-bmof.rst
 F:	drivers/platform/x86/wmi-bmof.c
=2D-
2.39.2

