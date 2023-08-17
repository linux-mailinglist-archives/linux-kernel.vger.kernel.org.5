Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20E77EE91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbjHQBKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347458AbjHQBKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:10:20 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5519E;
        Wed, 16 Aug 2023 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/pJUdBLfXj1B1WDyDQ15fjlR4oyo4SwgeP26Ydj270w=; b=2TZ1PDpWONs0F//wBvAFXMUo/H
        S1wMLOokmyY8Y5P+rXMVAWI+ckbpzdLQfgOcG4BN1Q96Twa05pziZdb6rT/+fFWUGqbUsMvvwajLF
        OFMWuHfxoldRaas9wxUhbUUervBtKJPe5+//6TY3LtjQ55hFrPXzKqCpvSAVdySIJ4cU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWRWc-004Kis-8m; Thu, 17 Aug 2023 03:10:10 +0200
Date:   Thu, 17 Aug 2023 03:10:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: net: Add HPE GXP UMAC MDIO
Message-ID: <bb3262ba-e820-49e1-ab38-2fa40ecd2701@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-2-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-2-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 04:52:16PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Provide access to the register regions and interrupt for Universal
> MAC(UMAC). The driver under the hpe,gxp-umac-mdio will provide an
> interface for managing both the internal and external PHYs.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Your Signed-off-by: should come last.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
