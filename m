Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C147D7DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbjJZHpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJZHo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:44:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790FC0;
        Thu, 26 Oct 2023 00:44:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CF8C433C7;
        Thu, 26 Oct 2023 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698306296;
        bh=XAlEIrmdypcb+KqT0LBcwNCR9qQHpu+C3FpeZNHMc+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1Lz0K6gFIUQPy+avCBiBd+4PEGxGPhbHeCaZODqJwq2+4LbcM9HCF/++6nFWaUqe
         EXar9/f8++QDvGGx1aPprPH1gQbTGegDsg6wYo7+MUwWLG/yz+mJqYFY3rDPPSIU7H
         BAr3NK1WNpStquLTWMIjUnJZxwTzhJLdOZHENJR0D3Q+cuSt7Dq5nLkjL5jQnY5GjF
         yx84orB3vgy1RldTVA76yhL5EjvxyUh/0fqdSc9i+34UL2FtZxyd3AJp1/+pmn0qHV
         TV0qpeMVpchjBZEZYXOn55Fdf/VwahdITQ7ArvchDfSO1CE0G0OG2c07DuIPW/29IA
         sLRcnTNvvVYwQ==
Date:   Thu, 26 Oct 2023 08:44:49 +0100
From:   Simon Horman <horms@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: microchip: ksz9477: Fix spelling mistake
 "Enery" -> "Energy"
Message-ID: <20231026074449.GM57304@kernel.org>
References: <20231026065408.1087824-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026065408.1087824-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:54:08AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin,

I noticed this one too.

Reviewed-by: Simon Horman <horms@kernel.org>
