Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D067B8168
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbjJDNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJDNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:54:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD1EAD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:54:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7939FC433C8;
        Wed,  4 Oct 2023 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696427675;
        bh=rlPu3O1Qd3M3TwWAX0nB0L1fM6tsuvYQG9C6oxCBGHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBR1cJ4e8z1cefVOxoXKfsFkG0PMnCZxNtku+ODpsKW41kS6yp9V7CSHR9DEwvAoI
         jlR3XKvGNGl+9yEPcp82tbqrIP5KpThk9dfSr5jI/dfHQKuBorZdC7ko4ch239Xur6
         CGHstoQMmcWdsnwBLtmnzcAPlOvKeAlkCEM3VkJChbK6XsO4VbcxQusr5dIwML+05G
         qUz72H+rzy+dCo/Oanvf08mLcCJUA1gtMjE79U8GotO2zvGfZvkJ+EJcUebM27SlHd
         MizaHt+HjYpp89ji44Lmdy//NtMjbqDzmxtQnNX7njZGtDAHnA1hM5OH0QA/RrkqsT
         4AU2L0stMUysg==
Received: (nullmailer pid 2784664 invoked by uid 1000);
        Wed, 04 Oct 2023 13:54:33 -0000
Date:   Wed, 4 Oct 2023 08:54:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] docs: dt: writing-schema: add example for multiple
 DT_SCHEMA_FILES
Message-ID: <169642767269.2784606.14360719853383172840.robh@kernel.org>
References: <20231002183813.1702052-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002183813.1702052-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 02 Oct 2023 14:38:12 -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Variable DT_SCHEMA_FILES can specify multiple files or patterns, but the
> documentation does not indicate how to do it. Each entry needs to be
> separated by a column symbol ':'.
> 
> Add an example to make it more obvious how to specify multiple
> DT_SCHEMA_FILES.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> Link: [v1] https://lore.kernel.org/all/20230928190259.3497563-1-hugo@hugovil.com/
> 
> Changes for V2:
> - Change description to indicate that multiple patterns can also be specified
> 
>  Documentation/devicetree/bindings/writing-schema.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks!

