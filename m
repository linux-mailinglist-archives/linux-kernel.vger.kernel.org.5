Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4060B7F6B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjKXFNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXFNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:13:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C4D6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 21:13:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889F5C433C8;
        Fri, 24 Nov 2023 05:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700802808;
        bh=hagFZGT8Lu9FB4is0l4tvlmYdCQ6vvVTipY5bbk8lgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awxRRuS00+ASnIfcDh6qu9/zntoouhOmUlG8lbDMGf+h3bFc4FdiphfxdYWMajLQO
         uiLqRNq0V5b9kJTzEt0jV5nPzCITn6P6f3nl3Xudjs/+2cdAjk6OozbBUuCYYnoba2
         mHTaLRM/Oa28ExhuvRTv4epvw3cbpjnm0NbFQtRpo9OjKY1i/XoSRWi0VvUSgFTcvu
         L2pgvNvZzhTX5c6rRzALPq+nL2XjLsXtUZjSmV9USUEAv+uxBBATvBEhr6/yp9admC
         hVndkmygF3O/o+rQhiCVC6cznDOXVALoQ24hPCdwuVK74NjSh1KLOKxypcM2UU8xLV
         LifT6/+GnRsQA==
Date:   Fri, 24 Nov 2023 10:43:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sneh Shah <quic_snehshah@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net] net: stmmac: update Rx clk divider for 10M SGMII
Message-ID: <ZWAw85nx/T0xC+Vk@matsya>
References: <20231124050818.1221-1-quic_snehshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124050818.1221-1-quic_snehshah@quicinc.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-23, 10:38, Sneh Shah wrote:
> SGMII 10MBPS mode needs RX clock divider to avoid drops in Rx.
> Update configure SGMII function with rx clk divider programming.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
