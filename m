Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E077F3A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjKVAEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKVAEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:04:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A8CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:04:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBAAC433C8;
        Wed, 22 Nov 2023 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700611444;
        bh=5oAfyrQ54eQP95rCl5KFP1aGqc2no3aE5cb5/AYs2mY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RAfudj746OLK8bT5EoA0b8TJUszsB11Wrbf856H0urW/Hlz/0v+bl2IElv0nQ0I3a
         hzt0bDPB/w3pXh3ynlyvXBBJxs4Kn4LY6tnryG8g+zrCYb2k0OTrKDK5IP8SAN6dJW
         OwpM4yEe6a9/Yh692WViISP/wfle8dJcY7IrMLyJglZ9fuACqW20myLe9KaZ8ZQZfG
         d1NUquMumhtK89p1i3vt3UweR5/hphaW0N26Bo+YPcLC8vYNSbzXytuX8lezlF7XTD
         ZJuXjerdCnQv+KCkzwQKM/J1VYLAxLncilqxShybZ4UzVe19z8tKoCbFI1xuQoEETK
         DQv27B7Gg2XVQ==
Date:   Wed, 22 Nov 2023 09:04:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: TRACING: Add Mathieu Desnoyers as Reviewer
Message-Id: <20231122090400.b6af7c22775db1f7daa9c45b@kernel.org>
In-Reply-To: <20231115155018.8236-1-mathieu.desnoyers@efficios.com>
References: <20231115155018.8236-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 10:50:18 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> In order to make sure I get CC'd on tracing changes for which my input
> would be relevant, add my name as reviewer of the TRACING subsystem.
> 

Yes, you should be a reviewer for tracing subsystem :) 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4cc6bf79fdd8..a7c2092d0063 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21622,6 +21622,7 @@ F:	drivers/hwmon/pmbus/tps546d24.c
>  TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
> +R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
