Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12AB80DAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjLKTPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344614AbjLKTPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:15:18 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D348EA;
        Mon, 11 Dec 2023 11:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=sX7QcabkKreW0nk13tl5Bg0IqAATWRDSei+ICYJBEbs=; b=trJ/xQh0dlne+z7bPjiT3nHt8u
        lYNefB9wAiT7w2YFYog/vuIT62FkyySyz+SXfFQkvcjMnqY+GV0NczW1Kcvxl/fWUPHZMp3ssYnka
        xVjeAbl47hKvg3xXq6Qn6y8fzhMbwFn177aAsgO5Cc0J5Tj8H6yOE7Tk46rk/yeeXofU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rClkM-002eap-UN; Mon, 11 Dec 2023 20:15:18 +0100
Date:   Mon, 11 Dec 2023 20:15:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH v8 2/3] dt-bindings: arm64: add Marvell COM Express boards
Message-ID: <f28ea54c-84a5-4796-9ce9-19c147696c7f@lunn.ch>
References: <20231211171739.4090179-1-enachman@marvell.com>
 <20231211171739.4090179-3-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211171739.4090179-3-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:17:38PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add dt bindings for:
> CN9130 COM Express CPU module
> CN9131 COM Express CPU module
> AC5X RD COM Express Type 7 carrier board.
> AC5X RD COM Express board with a CN9131 COM Express Type 7 CPU module.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
