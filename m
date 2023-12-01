Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6380166C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjLAWfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjLAWe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:34:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9350B12A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:35:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14851C433C7;
        Fri,  1 Dec 2023 22:35:04 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.64-rt17
Date:   Fri, 01 Dec 2023 22:33:51 -0000
Message-ID: <170147003175.315432.12322961896739098066@demetrius>
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 6.1.64-rt17 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 10278c5eac700351db2dbfcce88be2df51725931

Or to build 6.1.64-rt17 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.64.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.64-rt17.patch.xz


Enjoy!
Clark

