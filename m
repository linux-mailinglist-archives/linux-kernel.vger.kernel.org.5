Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD71805C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjLEREp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEREm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:04:42 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB5DA9;
        Tue,  5 Dec 2023 09:04:48 -0800 (PST)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DA3963FF90;
        Tue,  5 Dec 2023 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701795886;
        bh=L3Hv3hhw1XNFiYnm+KfMClgCTUgvdYKgMHhrQDcGnsY=;
        h=From:Subject:Date:Message-ID:To;
        b=Kw9ugRFtyuC8g+dOZ3qEddvVOmywyGLBZH8KhRfX4H3iHYgVd6Gc1m271XwrJB3vZ
         atGtw/8eZwyL6dlE8OI/xNmRyaeScY5tHu3aX8YS652asZtS5UBeUcMr2GzsUvrgXZ
         Q7TC/aWSnRJjDPBZwLZFpV5Y1LMLdeZ2RAT/nZSJNcWpYO0Qu2Uf456lWx3R0hJWd4
         WViVU2Mz9HUnacS8AHjKoTtqQYdTL/o31l3eZ7L8ErypCptsu3z3V+WkMzQ/DZmRgB
         tWGVjVOCmyuNyd4arQ3gTTN6RzHl4Y8suoLoFvCbqDlPHnSAW8uEgQ9JgD3WCJStek
         Uex5ttJ92xWgg==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.141-rt72
Date:   Tue, 05 Dec 2023 17:00:32 -0000
Message-ID: <170179563245.1513973.4035707288173577889@jupiter.home.arpa>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.141-rt72 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: e9e280348657bf29b5f35e37e34e4da26821116c

Or to build 5.15.141-rt72 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.141.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.141-rt72.patch.xz


Enjoy!
Joseph Salisbury
