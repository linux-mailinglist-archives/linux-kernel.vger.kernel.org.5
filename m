Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAE7EE67B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjKPSMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:12:23 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795921A8;
        Thu, 16 Nov 2023 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Dy6raJ/CUfjvTNheXRnlkCtCUSg34o+Shs1RwXwxo50=; b=foy417+0rwd88OmjIiXATRdbnM
        ebmY3QKC+9RcmTTKlAaWak/su2hkQZRHoLIkH9q7qaah/Oedanah7hl3YJYYeZPDwZ2B1wKlXmd9c
        cFXJGupiyyk4jm1MdT5u0lxJM/W+vwMS7hAc/yumY+702JR9NA5FULiSMAvSlTjVRm00=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r3gqR-000NVy-Iq; Thu, 16 Nov 2023 19:12:03 +0100
Date:   Thu, 16 Nov 2023 19:12:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Conor Dooley <conor@kernel.org>
Cc:     Luo Jie <quic_luoj@quicinc.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        corbet@lwn.net, netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: net: ethernet-controller: add
 10g-qxgmii mode
Message-ID: <739c89ec-739e-4c5d-8e42-88ed9a89979b@lunn.ch>
References: <20231116112437.10578-1-quic_luoj@quicinc.com>
 <20231116112437.10578-3-quic_luoj@quicinc.com>
 <20231116-flier-washed-eb1a45481323@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-flier-washed-eb1a45481323@squawk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 02:22:41PM +0000, Conor Dooley wrote:
> On Thu, Nov 16, 2023 at 07:24:33PM +0800, Luo Jie wrote:
> > Add the new interface mode 10g-qxgmii, which is similar to
> > usxgmii but extend to 4 channels to support maximum of 4
> > ports with the link speed 10M/100M/1G/2.5G.
> > 
> 
> > This patch is separated from Vladimir Oltean's previous patch
> > <net: phy: introduce core support for phy-mode = "10g-qxgmii">.
> 
> This belongs in the changelog under the --- line.
> 
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Are you missing a from: line in this patch?

You probably need to use git commit --am --author=<author> to fix
this.

	Andrew
