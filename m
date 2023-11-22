Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478A67F54E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjKVXkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKVXkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:40:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401B1B5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:39:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B994DC433CA;
        Wed, 22 Nov 2023 23:39:58 +0000 (UTC)
Date:   Wed, 22 Nov 2023 18:40:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] eventfs: Some more minor fixes
Message-ID: <20231122184015.79be22ef@gandalf.local.home>
In-Reply-To: <20231122141925.GE1733890@perftesting>
References: <20231121231003.516999942@goodmis.org>
        <20231122141925.GE1733890@perftesting>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 09:19:25 -0500
Josef Bacik <josef@toxicpanda.com> wrote:

> On Tue, Nov 21, 2023 at 06:10:03PM -0500, Steven Rostedt wrote:
> > Mark Rutland reported some crashes from the latest eventfs updates.
> > This fixes most of them.
> > 
> > He still has one splat that he can trigger but I can not. Still looking
> > into that.  
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks Josef!

-- Steve

