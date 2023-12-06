Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70780748A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442655AbjLFQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442614AbjLFQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:08:00 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC8A3;
        Wed,  6 Dec 2023 08:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2UxyokxjmvPqTPrwXVDTubcv9FjJjWbq5cXUewEFM/8=; b=EA2utCKaEEQSejX04+tFYkmXwb
        85hgwyHF3vqhtZASDp5nrvD4ZaA6G6QgUVPXI44lWW1bMfudK4kWUxbXLRZNN8qFMlwiMActnh83l
        ixitF1/S4J/B0zC162rn9bIjsgUohlZkcmzPyiCLD7RVNNJABdhW7iAd7xZmNNjAQCN0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rAuRH-002E1s-5A; Wed, 06 Dec 2023 17:07:55 +0100
Date:   Wed, 6 Dec 2023 17:07:55 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: dsa: microchip: use DSA_TAG_PROTO
 without _VALUE define
Message-ID: <488c0037-0cbb-43a6-8d02-0b5ac3eb84bd@lunn.ch>
References: <20231206160124.1935451-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206160124.1935451-1-sean@geanix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:01:23PM +0100, Sean Nyekjaer wrote:
> Correct the use of define DSA_TAG_PROTO_LAN937X_VALUE to
> DSA_TAG_PROTO_LAN937X to improve readability.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
