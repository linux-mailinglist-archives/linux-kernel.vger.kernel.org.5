Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8E7C7E87
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjJMHZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjJMHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:25:57 -0400
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9286BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1697181887; bh=WtRmLD1Mp4b3cYbHZuLnDLSCxG32Bx/bTBazWuGVctM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=GrtYxDkc5Ys329KTqjVJhKUjokB5IlHQ5iaPM5S3cQD6ZEU7Pzjyr/v7Q2hAsvuq/
         dzB/yMC1mr5JL0ptqJmsswVsGzEjQbmFyaNRrJTSAM6eZmWoFPm+/dZTwmkfoZWxo2
         ppfmA2dqMoQir3BaTo0IOLX9D1NREgESpCFArcbw=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri, 13 Oct 2023 09:24:47 +0200 (CEST)
X-EA-Auth: jTiSrLOGiU8ksF1WjCCAGJhVOJmHgyDFFmtU4oypyLLguqWkUGLdqoO3ivIt1H38B3Sg+csFNEEPrZ3s0zeWw1mVTBieraJI
Date:   Fri, 13 Oct 2023 12:54:43 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Deepak R Varma <drv@mailo.com>
Subject: ivpu TODO list items
Message-ID: <ZSjwuyCOL9Vb9+yb@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am shortlisted as a mentee for the LF Mentorship program. I looked at the TODO
file for the ivpu driver for my project tasks. Could you please answer the
following questions:

1. Is the TODO list up to date? If not, can we have it updated? Let me know if I
can help.
2. Is it absolutely necessary for me to have a specialized hardware to test my
patches? Is it limited to the 14thGen or above CPU or do I need more than that?
3. Is it okay for me to work on the TODO list items. Let me know if you have a
preference [Please note I just started a few months ago and still learning].


Thank you in advance.
Deepak.


