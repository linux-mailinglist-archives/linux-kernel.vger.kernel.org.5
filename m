Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A867F078A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjKSQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjKSQcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:32:14 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD7E11A;
        Sun, 19 Nov 2023 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=cRkNXHQqBugH+okpHtLhBtvcQo+QiZh/fs9a5Mg2o44=; b=B7qOjyfLxDJ5YK16VRgcKnRVBE
        DxFxMoH4L4ODpNLtCxIooe71JiWEBWWP3nTqDy+2LDuy11y/2cQFAWNH2VN1g80YgLmM8zozQ+DxE
        r7yRyVaKizFnAjSC62AETiTBlh3rVxIyRt49gT1cz8qlFggPpzaRCDnOf61Ngh0euLGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r4kiI-000ZcK-2i; Sun, 19 Nov 2023 17:32:02 +0100
Date:   Sun, 19 Nov 2023 17:32:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH v5 1/3] MAINTAINERS: add ac5 to list of maintained
 Marvell dts files
Message-ID: <0b0cbdef-47de-4bc3-929a-b91f935e5e5c@lunn.ch>
References: <20231119102638.1041978-1-enachman@marvell.com>
 <20231119102638.1041978-2-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119102638.1041978-2-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 12:26:36PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add ac5 dts files to the list of maintained Marvell Armada dts files
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
