Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B67DF294
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376409AbjKBMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347798AbjKBMhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:37:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B62C1B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:36:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6302EC433C8;
        Thu,  2 Nov 2023 12:36:36 +0000 (UTC)
Date:   Thu, 2 Nov 2023 08:36:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] eventfs: Fix kerneldoc of eventfs_remove_rec()
Message-ID: <20231102083634.5278a500@gandalf.local.home>
In-Reply-To: <0be16a8e-5f4f-4c26-d6b1-c090accfac5c@quicinc.com>
References: <20231030121523.0b2225a7@gandalf.local.home>
        <9d71fc3b-f7a9-9f23-6fbe-a7665954cd30@quicinc.com>
        <20231101160035.12824b55@gandalf.local.home>
        <0be16a8e-5f4f-4c26-d6b1-c090accfac5c@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 12:05:33 +0530
Mukesh Ojha <quic_mojha@quicinc.com> wrote:

> I will try to participate and take this in a good way..but i thought
> for easier change where there is no discussion is needed., it is fine
> to add if you have spent time in checking the code and change is proper.

If it's easy then automated bots will likely catch any issues. No need to
say you looked at it too. Otherwise we'll get 20 Reviewed-by tags on
comment changes.

A Reviewed-by tag has much more meaning when the code being reviewed is not
trivial, where questions about correctness is needed. In other words, if
something doesn't look quite right, ask. If it is, and the author explains
the reason it is, the fact that the explanation is now documented in the
archives is useful.

Thanks,

-- Steve
