Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76A7E9D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjKMN1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjKMN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:27:40 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C42D73;
        Mon, 13 Nov 2023 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=N5ifv1cr6Ysi7QPGqvW0ehIcDLlLuWs8Rj6Ky69UHAU=; b=je3dHoCn6b3t6S74Hk3VwSNVR2
        k7nLyA7xmawN/r1qIDf3laVJcPA3UIjfg4Mp0AevaMa4IHK7fCHkXUcdD+WTUIIwZp71PfyP490p7
        K/kpTT4A3qeUy1h5m9XSCSxs8c4iThbYuumVnYMYRqivxwX8XVkmsxfzJQVuEmeTEHgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r2WyQ-00044h-6r; Mon, 13 Nov 2023 14:27:30 +0100
Date:   Mon, 13 Nov 2023 14:27:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, srk@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: ethernet: am65-cpsw: Error out if
 Enable TX/RX channel fails
Message-ID: <5be409cd-8c72-4ca6-b6aa-ba588672b885@lunn.ch>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-4-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113110708.137379-4-rogerq@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:07:08PM +0200, Roger Quadros wrote:
> k3_udma_glue_enable_rx/tx_chn returns error code on failure.
> Bail out on error while enabling TX/RX channel.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
