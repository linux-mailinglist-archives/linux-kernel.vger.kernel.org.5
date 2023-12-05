Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C80805BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjLEQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjLEQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:25:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61449E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:25:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77456C433C7;
        Tue,  5 Dec 2023 16:25:42 +0000 (UTC)
Date:   Tue, 5 Dec 2023 11:26:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        mark.rutland@arm.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentaion:trace Add the git web link to view it on
 the browser
Message-ID: <20231205112608.76927866@gandalf.local.home>
In-Reply-To: <20231205035517.30534-1-unixbhaskar@gmail.com>
References: <20231205035517.30534-1-unixbhaskar@gmail.com>
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

On Tue,  5 Dec 2023 09:25:17 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> Thought this might help people to see the entire source tree on browser and
> explore.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/trace/ftrace.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 23572f6697c0..e768a4c91452 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -3731,3 +3731,5 @@ Currently, -mfentry is used by gcc 4.6.0 and above on x86 only.
>  More
>  ----
>  More details can be found in the source code, in the `kernel/trace/*.c` files.
> +Also you can see the trace source tree on browser `Git Link
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace>`__.
> --
> 2.35.8

I'm not a big fan of git links to code in the documentation tree. This is
more for those that want to play with it (compile and install), so I don't
think a web link is useful here. I rather have people download the code and
build it.

-- Steve
