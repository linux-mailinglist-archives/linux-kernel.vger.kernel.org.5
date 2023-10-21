Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF367D19DF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjJUAVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjJUAVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:21:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB91BF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:21:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042E5C433C8;
        Sat, 21 Oct 2023 00:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697847702;
        bh=JLVCFPS9n2+33q7bJ21lPZev0WogxM0z1ufKw+/bbgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HUzv6kl8RuaD6IsYol/bRb7WqlHaJzdRft7iXYjLlVHPgY2W0lt7tDek+fSceK4Pb
         LmSIbvb/r+yRWvdifgAHzTMrP5QNs4dagHauTRoGiOVXtOMcRM/ecdUAPmQngSl+f4
         Bs7fQEHYvKUpntZz3LwwQEBS/dJjnpUeqKzmT1SEBL3W+x2clk998+28Pd/4qNa5uj
         950IH/xcUnZN5reojytbMSrkpNDOuYD/SJgHggV9ydQrvdaQq8MVjtehEhwxZqdjjb
         CmIg0pwJmH87axy8QtYE4zLEg3f7lhk6h9xBX6igOslR9WSnUpxsseWMFrUc5doVJA
         QuqKoSBqneE4A==
Date:   Fri, 20 Oct 2023 17:21:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: Re: [PATCH net-next v6 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231020172141.0efaeb20@kernel.org>
In-Reply-To: <20231018175820.455893-2-florian.fainelli@broadcom.com>
References: <20231018175820.455893-1-florian.fainelli@broadcom.com>
        <20231018175820.455893-2-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 10:58:19 -0700 Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

This got marked as Changes Requested, I think it no longer applies :S
