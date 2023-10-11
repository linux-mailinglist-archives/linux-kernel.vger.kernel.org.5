Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09377C579D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjJKPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjJKPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:00:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB8692;
        Wed, 11 Oct 2023 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/8l3vkgAiOvv7zKd2KhH0NW8wKgOJVXtYiHkuGrerv0=; b=2FLLg5Gd2oRs59a5hLlwLXtkvo
        FcVcQdT9/spPuo9o+piyZDe+a8ws88xYT+GmVzq9z5Kw9ZYsKdAXtRPhgrUN9bUzdti5O+aVq3Fjn
        qeHxmytidKmCoq/fYlSuauUFFch/iFrPDw6wBbJkZP7OJx2ZaOdrS3hJgdhZRXEjq1DU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qqah1-001bac-Lb; Wed, 11 Oct 2023 17:00:11 +0200
Date:   Wed, 11 Oct 2023 17:00:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
Message-ID: <14224244-836e-4151-86e9-03414aabfe56@lunn.ch>
References: <20230906095143.99806-1-aford173@gmail.com>
 <8cf5b8d1-5f03-438a-94bb-5691dee8cc86@lunn.ch>
 <CAHCN7xJ_2HjQ8iCYimPG+CiMQuDy7YpG2sf6Vq30VsddaSs8CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJ_2HjQ8iCYimPG+CiMQuDy7YpG2sf6Vq30VsddaSs8CQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know who the right person is to ask, but is there any chance
> this can be accepted?

It did not help you did not make it clear who you want to merge the
patches. It is a good idea to use To: with the Maintainer you would
like to do the merge and Cc: for the others.

What is the state of patches? Has the other patch been merged?  If
just the driver change is left, please repost is on its own, and
follow:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

	Andrew
