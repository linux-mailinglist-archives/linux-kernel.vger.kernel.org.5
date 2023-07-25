Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C076230E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjGYUKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGYUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:10:49 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339B1BE2;
        Tue, 25 Jul 2023 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Tk/mPKqHXdmnqbdvlNHIzpocHa+rvwI5fnX9pZqEPtw=; b=l3jrjqotsNSrjgO8NCxHvPydPE
        56GLDVl0sMfCNF+kWeGzJFteSxoDurhaaKPs+rgY8vLtovey/HkkVgxs1dVtoGMQRdW7u2EzfP0cY
        TesfbOfo9XCyUsDo8nn9Dmc3LmdwNxXlQgW4eazSiMb88qMfk2fYZDQzJLlHJFSW6xG4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qOOMg-002ImK-FZ; Tue, 25 Jul 2023 22:10:38 +0200
Date:   Tue, 25 Jul 2023 22:10:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com
Subject: Re: [PATCH net-next v4 02/11] net: phy: nxp-c45-tja11xx: remove RX
 BIST frame counters
Message-ID: <b69feacc-27e6-4cb4-b6e3-33261db4c7cc@lunn.ch>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
 <20230724141232.233101-3-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724141232.233101-3-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:12:23PM +0300, Radu Pirea (NXP OSS) wrote:
> Remove RX BIST frame counters from the PHY statistics.
> In production mode, these counters are always read as 0.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
