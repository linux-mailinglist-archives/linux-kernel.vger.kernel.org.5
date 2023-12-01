Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59880041B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377631AbjLAGna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjLAGn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:43:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F4131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:43:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2828AC433C7;
        Fri,  1 Dec 2023 06:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701413015;
        bh=Ac2LAr8zXdRG53W9ecY2idG7L9BWseIgaVc9xlc+IgE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y54S440AsWcq4zKgpUJwb6Eo2jPhoX7OEwix9AjAOplmg8KzsEW4mWPmVLbS/be5P
         zg67q/E27Rcg0tCBvZ+v84oAdnRUG6p9jBD7oGTR3YuBkahqq+0Kxteh/bDjpNGiSw
         SXsByEmi9u5DSNcdMyAxlUkY1QomkRcc+INawIab8L8ILnzh6ODZe/T09BdZYJ89C/
         aEYeUCIeSx5bWkt+MZOkk0i36rjzxGnSyYlT8vey+E5MfWKBR/LoCWpcASpjBUmrBK
         ojgOYv3sryOwtdjHI771ExnzToumZEpVsmO5+PQLFNIqni8jAgTdkodgZeM5BdLnZa
         bSY0whrHcPqNg==
Date:   Thu, 30 Nov 2023 22:43:34 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Message-ID: <20231130224334.1c1f08c9@kernel.org>
In-Reply-To: <170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
References: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
        <170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 14:00:33 -0800 Kees Cook wrote:
> Applied to for-next/hardening, thanks!
> 
> [1/1] net: mdio: replace deprecated strncpy with strscpy
>       https://git.kernel.org/kees/c/3247bb945786

newer version of this was posted...
