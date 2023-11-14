Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE597EB631
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjKNSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNSPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:15:31 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81585129;
        Tue, 14 Nov 2023 10:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=uADPOJd28K7xeDwvDsxrux/EuRs6b2nWjJMNpQr42QE=; b=M/1p3//l7HqWAQx67iyrTANPVq
        gzv8D4LUWI6o8Dp92GGq/lM6hHjxXg1JaO8Ovp//XLS4u/Vu5DFHG+Ze2/npyRMPggBODCWP98DkC
        ywexobIpUMpt3iYcg9wcyb75i0ibTSKD54u3rRtRkdyUQk+cGWYfVdbq7oVg9issGdhU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r2xwY-000BJj-HP; Tue, 14 Nov 2023 19:15:22 +0100
Date:   Tue, 14 Nov 2023 19:15:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 2/8] net: dsa: qca8k: Make the QCA8K hardware
 library available globally
Message-ID: <744b25ee-cbdd-48e3-86ab-92be412b32ae@lunn.ch>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-3-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-3-romain.gantois@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
> -			  struct dsa_mall_mirror_tc_entry *mirror,
> -			  bool ingress, struct netlink_ext_ack *extack)
> +				 struct dsa_mall_mirror_tc_entry *mirror,
> +				 bool ingress, struct netlink_ext_ack *extack)

This looks like a whitespece change which should not be here.

     Andrew
