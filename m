Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3672B7C71C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379483AbjJLPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379486AbjJLPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:44:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CFBD3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:44:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2CAC433C9;
        Thu, 12 Oct 2023 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697125468;
        bh=GICrSG2Yr7cyuandvlnQB4wtkQU/ONqfvxNpkn64C6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urSiZTDhcxBtHJPTvqtBC4cbLtC9OIQZFQf/8DnE7ETAiwuqDBbUXRQuEm41SaASc
         QIW6lXY9WRyLn50Pu+zz9QzE+yC+dw5RwAzE4LdRW9RHA+84bytQo5AbqNAJyDSkzP
         CoH1XRfilCg0doAuE8Yd4JdRbcCsQ6KRsIbJHkX/MKZPafuH6b8f7LPWmztVh3X9z5
         9Cyy+vzf8G5cPYYhDnnTFtZW5uHUt4Yolt7eqNWMfq6bNdAE9ciEgZlRXCYiakemly
         aPm3MhhdFqCQhK/TM4FNWQimBRHYFA5UoIuBnHCjbN9RkeL8lluk7L1aDOjP0oeLbx
         KpcJdVuuX7PMA==
Date:   Thu, 12 Oct 2023 17:44:22 +0200
From:   Simon Horman <horms@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, patchwork-jzi@pengutronix.de,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH net-next] net: stmmac: fix typo in comment
Message-ID: <20231012154422.GE1178137@kernel.org>
References: <20231010172415.552748-1-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010172415.552748-1-j.zink@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:24:15PM +0200, Johannes Zink wrote:
> This is just a trivial fix for a typo in a comment, no functional
> changes.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

Thanks,

I checked and codespell doesn't flag any other spelling errors in this file.

Reviewed-by: Simon Horman <horms@kernel.org>
