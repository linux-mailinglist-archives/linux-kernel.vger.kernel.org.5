Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F57EF5EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjKQQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjKQQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:11:39 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F248D7A;
        Fri, 17 Nov 2023 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=oDai2uoUm5vGeh5ZPqmeEdbdW8V1DW0OcsGodmj2JN4=; b=ilTve3hJgBLOOHEHLwsdUxBU9m
        T1cjCITI+p46Ua07x8MkBdIff0FlO9gxDgGNZQTV7PBc4ZxjqlYXOsnf3viut+Ey4sMu/PjY/ZHad
        oqw/hQn4/d/ZPYjeGyk0Mky0SXq559m0dn/EVtKPhFD3IB0xmpP+D5rPMRnMDhEUXbS8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r41RB-000SG3-8k; Fri, 17 Nov 2023 17:11:21 +0100
Date:   Fri, 17 Nov 2023 17:11:21 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/4] net: ethernet: ti: am65-cpsw: Re-arrange
 functions to avoid forward declaration
Message-ID: <755fc764-0c68-4171-9af0-507f8bbe5357@lunn.ch>
References: <20231117121755.104547-1-rogerq@kernel.org>
 <20231117121755.104547-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117121755.104547-3-rogerq@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 02:17:53PM +0200, Roger Quadros wrote:
> Re-arrange am65_cpsw_nuss_rx_cleanup(), am65_cpsw_nuss_xmit_free() and
> am65_cpsw_nuss_tx_cleanup() to avoid forward declaration.
> 
> No functional change.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
