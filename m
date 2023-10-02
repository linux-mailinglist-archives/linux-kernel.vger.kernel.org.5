Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557B47B588A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbjJBQ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbjJBQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:57:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CA7A9;
        Mon,  2 Oct 2023 09:57:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B57C433C7;
        Mon,  2 Oct 2023 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265826;
        bh=O2KXjFpK9ctoc+cpO1etAigjP8A2IP2SYttVxi/uXXQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TU/maBeSE7H2YjfW8JgfQjjsVkcIhhk96pKXA/djz4Y3N/2EVQPLgsLmaYuNGCPsF
         iYeaJTqDANypeHgTNvOy576/oaxHwC7UjUfOA+IbamRHOnsmuq3aZZ68dPjaSVC/if
         UnnymxxPjcATfHwTrWpkG4K9GWr0buN1dFEz6l6mqgP+fXD6cQkTwV4YnYpRPMilld
         loiaUU5djrRT/ze1wfdAt7QumT7OH3qws3CuWr6xXsfuke8DC8OPWkZVsuiLQVRlCW
         vo0MuVlGr39kIcMk4Vy2qXxQjuwGru+olapFflqMKE97rnc7FjsS8cMBG+HLI7onEh
         d9wj1D1PRUx7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary (void*)
 conversions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919044916.523308-1-yunchuan@nfschina.com>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     chunkeey@googlemail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169626582314.3936351.11116263813415463001.kvalo@kernel.org>
Date:   Mon,  2 Oct 2023 16:57:04 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Yunchuan <yunchuan@nfschina.com> wrote:

> No need cast (void *) to (struct ar9170 *), (u8 *) or (void*).
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6c751f1a7bb8 wifi: carl9170: remove unnecessary (void*) conversions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919044916.523308-1-yunchuan@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

