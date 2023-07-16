Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B10754F17
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGPOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGPOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:48:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BFE1B4;
        Sun, 16 Jul 2023 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=CbkBfBpRSVPwxZYI1N0yM4KwsV8EQ6xyHl2iM6/2ntI=; b=TMLieLbhW0t0Z1awveZlk+5D7I
        1RtPurTJ7fjdBrDbH6oHnWblypFpg/IffzJEPdlsqhcQhC7vFu5uCLO4eLaRrMu9xEPrRXSYPrPNV
        xQ9Bo1DRWz6r7u5l4hcBSBrvnzNVK2kPaC2VTDCzqW8D31w11xJQmCC9nR3mlhgR+BpU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qL33F-001U24-TI; Sun, 16 Jul 2023 16:48:45 +0200
Date:   Sun, 16 Jul 2023 16:48:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] net: phy: at803x: remove qca8081 1G fast retrain
 and slave seed config
Message-ID: <8d2dd95b-13f7-41d8-997f-d5c2953dcb06@lunn.ch>
References: <20230716084924.9714-1-quic_luoj@quicinc.com>
 <20230716084924.9714-6-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716084924.9714-6-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 04:49:23PM +0800, Luo Jie wrote:
> The fast retrain and slave seed configs are only applicable when the 2.5G
> ability is supported.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

FYI: You normally have Signed-off-by: last. No need to resend, but
please keep this in mind for the next patchset.

    Andrew
