Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06AE7D4526
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJXBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjJXBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:52:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9730D73
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:52:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97FCC433C7;
        Tue, 24 Oct 2023 01:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698112343;
        bh=FbA3kbFjjDVuh57fCZqykHjH+Ku4YvHw9Cgw9uAsT4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IBC9ySoFq2An4uYU54Q0y/1m+rXFynXkRFfPs/T7jqbRt63FOQJp0TwO5MpTFxtAw
         5smS9TbQIzL9RevrDH/NnGQP5e3IHVCm39i3E3yzYyJ4IdwYlWDafhgjCO4Vk57qjO
         fJNgyVEnB71PFGfL8Qo4lbi42J04ZM1dCrU700oe8gSQ0xQXTZ1eTyO6juxOJo/olY
         ab1aogVQQJkN4LiElXX57Y30HQjk+AJT792sl/aKI//4wlkHcDeQ6UD4Y3VmDlaJpT
         KiJKRe8tcEsBTaK+QZnDa3H3vYH0OzMVFuD2MRd836fWZiH2eH5TrnzPmyMGRFp6+z
         F3eS98fzmM5zg==
Date:   Mon, 23 Oct 2023 18:52:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Message-ID: <20231023185221.2eb7cb38@kernel.org>
In-Reply-To: <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
        <20231023032905.22515-3-bagasdotme@gmail.com>
        <20231023093837.49c7cb35@kernel.org>
        <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 07:11:12 +0700 Bagas Sanjaya wrote:
> > 14 patches authored and 15 signed off?
> > Let me be more clear this time - nak, please drop this patch.  
> 
> Or maybe as well drop INTEL WWAN IOSM DRIVER entry (and let
> WWAN subsystem maintainers handle it)? I don't want
> people get their inboxes spammed with bounces against
> his addresses, though.

Right, sorry, still delete him from the MAINTAINERS.
Just don't add him to the CREDITS.

> He's now in a state of limbo. He has significant contribution
> (and gets listed by get_maintainer script with (AFAIK) no way
> to filter him out), yet emails to him bounces. What will be
> the resolution then?

Yes :( Not much we can do about that (even if we drop him from
maintainers all fixes will CC him based on the sign-off tags).
