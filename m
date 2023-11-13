Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FD27E9D14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjKMN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjKMN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:26:34 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A23D73;
        Mon, 13 Nov 2023 05:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=d1y3hkxjJ0QuBdNpH+T8ziGX5fUoiIFtqxC6QsdRKiA=; b=ji2CKF8TxHoXRPxdYPQOjhwScP
        3x+os9ea0KP5QeHv+yAA7nGC/Iw1OfkkrLaK/ZgJlSGgVszhm91AncajC18OsRGZdXG8s2bABBA1S
        4+Gb0ppvF9WVLpTIKzzde7Peen2kGKhn1HfqEvbzoBdhpp9ogMvv4J3y0WNOYGvZAiPI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r2WxB-000434-CD; Mon, 13 Nov 2023 14:26:13 +0100
Date:   Mon, 13 Nov 2023 14:26:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, srk@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: ethernet: am65-cpsw: Add standard
 Ethernet MAC stats to ethtool
Message-ID: <1427fe86-9802-4d7a-b010-96c66c7bf8c3@lunn.ch>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113110708.137379-2-rogerq@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:07:06PM +0200, Roger Quadros wrote:
> Gets 'ethtool -S eth0 --groups eth-mac' command to work.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
