Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7608089D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442573AbjLGOGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjLGOGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:06:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C84122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:06:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3E4C433C8;
        Thu,  7 Dec 2023 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701958017;
        bh=xTh+lYWi7+gEvbYpEe+2SLArpLruhAgZVoqIIqhHYkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXausfPyYF5Knz6tChkiLC3ES4oc2iPudrxyUVvZtZtYPOccQF6kWPTOUfUBP0hT1
         G+AZtlPaHa5Q4ZeYP2/BVam8FwMJxpN3bN4FMT9/48hjwQZVKlJLpmhYV7zOooMvFL
         Cu7SWr26r8nnToEyEc/HTTcl3j8+q38XSiQ+5j/K7lnSAnkaRd8l5SBhJJgHR8iDym
         Y0NyDL5iCEIqI9hZwRq0RCZ/hZG/hvRvVcCr+EoBkcZyVC0aH1fo6K30rOGdkDGnmr
         2E7P7Y1sGPR+fttDca0lacBoexFcVYtxP+WgKI2rGRWeb+bRA7PKTrIxtNEjKskDHP
         sSaAogN+3W1fw==
Date:   Thu, 7 Dec 2023 08:06:55 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cfg80211: Add my certificate
Message-ID: <ZXHRf5uEMO1kMIKY@do-x1extreme>
References: <ZXHGsqs34qZyzZng@wens.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXHGsqs34qZyzZng@wens.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:20:50PM +0800, Chen-Yu Tsai wrote:
> As announced [1][2], I have taken over maintainership of the
> wireless-regdb project.
> 
> Add my certificate so that newer releases are valid to the kernel.
> Seth's certificate should be kept around for awhile, at least until
> a few new releases by me happen.
> 
> This should also be applied to stable trees so that stable kernels
> can utilize newly released database binaries.
> 
> [1] https://lore.kernel.org/linux-wireless/CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com/
> [2] https://lore.kernel.org/linux-wireless/ZWmRR5ul7EDfxCan@wens.tw/
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Seth Forshee <sforshee@kernel.org>
