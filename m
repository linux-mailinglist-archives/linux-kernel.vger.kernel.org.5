Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9775D946
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGVCz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjGVCz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AAD10E5;
        Fri, 21 Jul 2023 19:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D0A961DCA;
        Sat, 22 Jul 2023 02:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34096C433C7;
        Sat, 22 Jul 2023 02:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689994523;
        bh=gVyAOpDYnIY9wjG1dKA++oAIaxdquYahQk+hSoMtifc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUQPrvDWSmMsIjRk3cQpn8aL7IPa/rN8lScqE5nBslfiphjvfq8HtDcImlOKVyXTn
         x436Y1mxahl9sI0JLnFKgE+Zg55QW/50QGYZI7J/9RbiLLUKRp8Pw8MVhWulwgvMau
         git0Y1AjJoJeId9/ITgQiwPfPfUcBTqVboD6K221b9ON3skFctBzZ85YHtFEFO5DoX
         Ur7RWG4i/T54dzCbKs4qidVRdmEWb1B0hRr7b6MRunbspzL1UFLqkjkIVKNmz8nG/f
         vOM4Tl2/05j2LsuNMk//W/eo/qin6KLK56kUjzehTS8CfdFjpZbRVydaPJE20TW9RX
         P6I+RgPevKSoA==
Date:   Fri, 21 Jul 2023 19:58:42 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: qcom: rpmhpd: Use the newly created generic
 RPMHPD bindings
Message-ID: <4ghmbalxufhf4fmj2vtj32rgvygomnxih6vpxv2pbh66mxahqf@77kfeyf2yku2>
References: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689744162-9421-3-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689744162-9421-3-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:52:42AM +0530, Rohit Agarwal wrote:
> Update the SoC SM8[2345]50 entries to use the new
> generic RPMHPD bindings.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
