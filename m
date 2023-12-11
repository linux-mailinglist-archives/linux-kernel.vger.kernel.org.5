Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87680DAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjLKTPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKTPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:15:00 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F3C0;
        Mon, 11 Dec 2023 11:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=WOso+pBmLou5CWghhufYbUN6QGAKv2w+0GIVbbVVk1Y=; b=YNrEZQS5GpbhYvnAh8ioHpQAjx
        972QjT0Ahb2fTQquF1sESoXaldKDQO0FSgWhcrLPoS4Akx2OKEfb/WCqNxTXRfZ5eZvQOr1b/Rtaa
        WZbYQIWoSWGefoxhdTpnr8phFaXQFDn4QBD+nczQkeAj0CsTsBYvO8xky3Osp0Byx0zg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rCljw-002eZx-QC; Mon, 11 Dec 2023 20:14:52 +0100
Date:   Mon, 11 Dec 2023 20:14:52 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH v8 1/3] MAINTAINERS: add ac5 to list of maintained
 Marvell dts files
Message-ID: <2920ed0b-dda0-4a57-8097-52fd532d9f63@lunn.ch>
References: <20231211171739.4090179-1-enachman@marvell.com>
 <20231211171739.4090179-2-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211171739.4090179-2-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:17:37PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add ac5 dts files to the list of maintained Marvell Armada dts files
> by defining the entry as covering the entire marvell arm64 directory
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
