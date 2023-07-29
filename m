Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5052D767CA8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 08:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjG2GyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 02:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG2GyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 02:54:10 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A226710CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 23:54:05 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T6rwAJ000962;
        Sat, 29 Jul 2023 08:53:58 +0200
Date:   Sat, 29 Jul 2023 08:53:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: nolibc: add myself as co-maintainer
Message-ID: <20230729065358.GB956@1wt.eu>
References: <20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:21:52PM +0200, Thomas Weiﬂschuh wrote:
> As discussed with Willy, Paul and Shuah add myself as maintainer for
> the nolibc subsystem.
> 
> Link: https://lore.kernel.org/lkml/7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b87fbcecd905..a67b50caea2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14993,6 +14993,7 @@ F:	include/linux/power/bq27xxx_battery.h
>  
>  NOLIBC HEADER FILE
>  M:	Willy Tarreau <w@1wt.eu>
> +M:	Thomas Weiﬂschuh <linux@weissschuh.net>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
>  F:	tools/include/nolibc/

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
