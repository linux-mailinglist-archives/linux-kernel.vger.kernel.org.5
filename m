Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4EF76F1E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjHCSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHCSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:31:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD51110
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691087513;
        bh=1MJdNmTkgtKX/vx+dYeTpSYV0qY7AMfZAHv0pQ3nn1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eo8K/2w4NP5Nkghrx4f1Mc3bICEbLK35iVKUITOC1pbTqbvtKLFFMI+ED7n79co5A
         4fJz+6390KtI40iTaVlv8hII8R/pwRY1Acy2gGOk/5jzDKtVY6+GHaQZpwqUsYs22+
         N+Io4jZtU+AES7dJc1ulC+gFK6r+jO5sGvKFYtzg=
Date:   Thu, 3 Aug 2023 20:31:50 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: nolibc: add myself as co-maintainer
Message-ID: <1f85e8c3-e07d-482f-aa90-5e6631bc7873@t-8ch.de>
References: <20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, 

On 2023-07-28 23:21:52+0200, Thomas Weißschuh wrote:
> As discussed with Willy, Paul and Shuah add myself as maintainer for
> the nolibc subsystem.

it seems I forgot to send the nolibc maintainers update patch to you.

My bad!

Willy and me wondered if the patch could go through your tree?

For you convenience the link to this patch on lore (with the Ack from Willy):
https://lore.kernel.org/lkml/20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net/


Thomas

> Link: https://lore.kernel.org/lkml/7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop/
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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
> +M:	Thomas Weißschuh <linux@weissschuh.net>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
>  F:	tools/include/nolibc/
> 
> ---
> base-commit: f837f0a3c94882a29e38ff211a36c1c8a0f07804
> change-id: 20230728-nolibc-maintainer-ebdd50c844ed
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
