Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD86803E60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjLDT1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:27:15 -0500
X-Greylist: delayed 230 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 11:27:21 PST
Received: from mx.sdf.org (mx.sdf.org [205.166.94.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E05AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:27:21 -0800 (PST)
Received: from sdf.org (IDENT:xuser@sdf.org [205.166.94.16])
        by mx.sdf.org (8.16.1/8.14.5) with ESMTPS id 3B4JNSdf018971
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO)
        for <linux-kernel@vger.kernel.org>; Mon, 4 Dec 2023 19:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sdf.org; s=sdf.org;
        t=1701717810; bh=pXouHljU6wy8igDdyuIOKjLjmhOSVhrdlVlJPvMkFBI=;
        h=Date:From:To:Subject;
        b=aABln2AajdTYHwGk6qQ/geJPQRr05uiw4gozqSF6ch1INXboIUQbOdM/IzX6mqQ9K
         D1Cx0tb5yKySVD7DgbWEaAFcNyUjXN8BUmXTdhKvQIMYtOqRtpih7LgnkaYHTiHmLo
         omXeyt//2VT5zZzwka6YgeNr0WG7d4NJXPmaZAY8=
Received: (from xuser@localhost)
        by sdf.org (8.16.1/8.12.8/Submit) id 3B4JNRS1002936;
        Mon, 4 Dec 2023 19:23:27 GMT
Date:   Mon, 4 Dec 2023 14:34:51 -0500 (EST)
From:   xuser <xuser@sdf.org>
X-X-Sender: xuser@x86toapple.org
To:     linux-kernel@vger.kernel.org
Subject: Re: kernel prolems kernel version "3.2.0-4-amd64 #1 SMP Debian3.2.78-1
 x86_64 GNU/Linux"
Message-ID: <alpine.DEB.2.02.2312041433230.3769@x86toapple.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What does this mean:?
;--------------------------------------------------------------------------
[ 8805.024090] PM: Restoring platform NVS memory
[ 8805.024090] Extended CMOS year: 2000
[ 8805.024090] Enabling non-boot CPUs ...
[ 8805.024090] Booting Node 0 Processor 1 APIC 0x1
[ 8805.024090] smpboot cpu 1: start_ip = 9a000
[ 8805.020085] Calibrating delay loop (skipped) already calibrated this CPU
[ 8805.036130] CPU1 is up
[ 8805.037927] ACPI: Waking up from system sleep state S4
[ 8805.070012] Uhhuh. NMI received for unknown reason 21 on CPU 0.
[ 8805.070012] Do you have a strange power saving mode enabled?
[ 8805.070012] Dazed and confused, but trying to continue
[ 8806.141328] PM: early restore of devices complete after 16.802 msecs
[ 8806.233942] e1000e 0000:00:19.0: setting latency timer to 64
[ 8806.233995] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[ 8806.234198] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[ 8806.234222] usb usb3: root hub lost power or was reset
[ 8806.234235] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[ 8806.234257] usb usb4: root hub lost power or was reset
[ 8806.234267] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[ 8806.234290] usb usb5: root hub lost power or was reset
[ 8806.234302] ehci_hcd 0000:00:1a.7: setting latency timer to 64
;----------------------------------------------------------------------
This happens after hibernating
Thanks,
--Xuser x86

