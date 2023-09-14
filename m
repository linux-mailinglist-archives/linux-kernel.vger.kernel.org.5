Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC367A0447
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjINMsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjINMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:48:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F061FCE;
        Thu, 14 Sep 2023 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=CVUvxHBM5O+MyRP23hv5Z9PIto6UUkP3gySpL3i25V4=; b=0glgrg6+vAUCsCZ9zCyFg+D6l8
        g6gESlAheEx5eS8arfXuZ2S1IXdaN/GKGz807o99/aFKSFn92P6uIt8I7E4J3TkbqE4flyVFMqA0r
        9NKseWcdI15cabQBJBEvLKuU6zVo3xurQ+sEO+xUts6+Hk6gncGNeio3I1dgFxJqb/tI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgllk-006P7i-Rw; Thu, 14 Sep 2023 14:48:28 +0200
Date:   Thu, 14 Sep 2023 14:48:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr
Subject: Re: [PATCH 1/2] arm64: dts: marvell: uDPU: rename the SFP GPIO
 properties
Message-ID: <a6d9e914-25ad-4bc2-8eb7-43bf31ada00b@lunn.ch>
References: <20230914094550.1519097-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914094550.1519097-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:45:00AM +0200, Robert Marko wrote:
> Rename the GPIO related SFP properties to include the preffered -gpios
> suffix as defined in the SFP schema.
> 
> This fixes the following warning:
> arch/arm64/boot/dts/marvell/armada-3720-eDPU.dtb: sfp-eth1: 'los-gpio', 'mod-def0-gpio', 'tx-disable-gpio', 'tx-fault-gpio' do not match any of the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/net/sff,sfp.yaml#
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
