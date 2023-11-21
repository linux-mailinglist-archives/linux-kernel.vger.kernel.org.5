Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258557F2FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjKUNyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjKUNyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:54:52 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B9D79;
        Tue, 21 Nov 2023 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=iAltbJrZNA/R9xdaEOLVfyowdzRQUxOd0WzcTS+2T0Y=; b=jpJa7ewHbzi7uwU/x7A34+Dy+e
        YhMklydm+MG8FLwGFegi+1q78SrQQsnrUDSTGVWaJu57Z6ps7j9hnNRC+Vn93A0OkqH7w/WtwZSiU
        cLyme7RzaC98Bl8YCI6VReYxj/OpZwUfoiLXd2FVvYck+0WTJRliQqLz+OtzPvXJ1vfU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r5RD7-000lEM-AC; Tue, 21 Nov 2023 14:54:41 +0100
Date:   Tue, 21 Nov 2023 14:54:41 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Marvell MBus driver to Marvell EBU SoCs
 support
Message-ID: <432a3d95-4cbe-49a5-a824-89b3ecdabf40@lunn.ch>
References: <20231121093414.11926-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121093414.11926-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:34:14AM +0100, Lukas Bulwahn wrote:
> While doing some code cleanup in drivers/bus/, I noticed that the file
> drivers/bus/mvebu-mbus.c has no maintainer.
> 
> Although the file has not been touched a lot lately, the git history tells
> us that Gregory Clement and Andrew Lunn integrated patches specific to
> this driver code. Further, the driver's config depends on config
> PLAT_ORION, and the code for this platform is defined in
> arch/arm/plat-orion/, which is part of ARM/Marvell Dove/MV78xx0/Orion SOC
> support with Gregory and Andrew already being its maintainer.
> 
> Add drivers/bus/mvebu-mbus.c to ARM/Marvell Dove/MV78xx0/Orion SOC support.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
