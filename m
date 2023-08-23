Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC8785915
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbjHWNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjHWNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF3E4E;
        Wed, 23 Aug 2023 06:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 963F566278;
        Wed, 23 Aug 2023 13:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEB5C433C8;
        Wed, 23 Aug 2023 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692796808;
        bh=f0rbuJKzxJUmE0jONDg4fsgdN5yoz/A4HK/gD16iZJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FeTlxarsXj63zuQXvhKyHBN3p+r/9c2+xWXOUG678UNedAmUsTY0h/UKiCrlstEvr
         uEgrnaLYLiVsS0N5DGkVwAy9CkvhRcO6GFXlyuWb2DYRVo+zg9LSCDOjD2zkUpQUe+
         UsBkv6P/3HYyK/4ZuW0xVc+1yMauNjcNosZ3//e91rBst3Kn2XXlEQtwqxwstdG5g5
         eXByjRwRdwNE4z3D0ZssIP2i0HTTffbe8eHTMBe7B8XZ5rukgxFIwyT3P3G+irHCVg
         ixFl/Oi7eKrSFjP1YQzTzP6avt/+vH/BgwzklyVx+t8exXy9G7dINJeR39+HhAY6rI
         yINPtptmANx9Q==
Received: (nullmailer pid 2204416 invoked by uid 1000);
        Wed, 23 Aug 2023 13:20:06 -0000
Date:   Wed, 23 Aug 2023 08:20:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aniket <aniketmaurya@google.com>
Cc:     manugautam@google.com, linux-i3c@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        joychakr@google.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i3c: Fix description for assigned-address
Message-ID: <169279680573.2204361.10063597911204356200.robh@kernel.org>
References: <20230822051209.2837818-1-aniketmaurya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822051209.2837818-1-aniketmaurya@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Aug 2023 05:12:09 +0000, Aniket wrote:
> assigned-address is a valid property for I3C device with or without
> static address. Fix the description and an example for the same.
> 
> Signed-off-by: Aniket <aniketmaurya@google.com>
> ---
>  Documentation/devicetree/bindings/i3c/i3c.yaml | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

