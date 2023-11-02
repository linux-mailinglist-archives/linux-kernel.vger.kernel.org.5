Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526EA7DEBCE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348458AbjKBEWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348429AbjKBEWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:22:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E6DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:22:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862DEC433C8;
        Thu,  2 Nov 2023 04:22:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyPDf-00EgnM-1E;
        Thu, 02 Nov 2023 00:22:11 -0400
Message-ID: <20231102042107.733372008@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Nov 2023 00:21:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: Final update for 6.7
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I said the last series was the final, well I lied.

This is more just enabling future seq_buf work and has nothing to do
with the eventfs file system (thank God!)

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 70a9affa930c7aeba27893c7d402ef1294f43aa2


Christophe JAILLET (2):
      seq_buf: Export seq_buf_putc()
      seq_buf: Export seq_buf_puts()

----
 lib/seq_buf.c | 2 ++
 1 file changed, 2 insertions(+)
