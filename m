Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9B7E2DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjKFUMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjKFUMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:12:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C25CD7C;
        Mon,  6 Nov 2023 12:12:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C8EC433C8;
        Mon,  6 Nov 2023 20:12:42 +0000 (UTC)
Date:   Mon, 6 Nov 2023 15:12:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [v6.6][PATCH 0/5] tracing: Backport of eventfs fixes for v6.6
Message-ID: <20231106151244.3337e9c6@gandalf.local.home>
In-Reply-To: <2023110620-wildcard-chrome-0d72@gregkh>
References: <20231105155630.925114107@goodmis.org>
        <2023110620-wildcard-chrome-0d72@gregkh>
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

On Mon, 6 Nov 2023 12:40:52 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> All now queued up.  Note, patch 1/6 needs to go to older kernels as
> well, according to your Fixes: tag, so if you could provide backports
> for them as well that would be great.

Done.

-- Steve
