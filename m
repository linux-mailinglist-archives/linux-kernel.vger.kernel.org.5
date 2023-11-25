Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0B7F88D6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjKYHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjKYHcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:32:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4408710E2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:32:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A24C433C9;
        Sat, 25 Nov 2023 07:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700897549;
        bh=rwChtd2K3J2OWFVntCNJt5iOvMrw3NNz5tNPNfg9tF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9s5B+yagysmsj8Lq8PJMbAt/SHovHA1hIsdKFXR4FYrUAUNRdqf+5fnaHJfsF9rU
         5Fv3+2GDoS7GGkpQYjXF097C7QAB84WaRt38i9cs3Fw+3fzXjDufBNLVZxEJWVIU43
         FQ+9QJtR87oSChuPW/1Vp3Is/D4cjk1fGIEmUCOA=
Date:   Sat, 25 Nov 2023 06:53:05 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luka Panio <lukapanio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v10 1/2] Add a compatible for Xiaomi Pad 6.
Message-ID: <2023112529-fetch-unwritten-bdbd@gregkh>
References: <20231124212732.731419-1-lukapanio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124212732.731419-1-lukapanio@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:27:31PM +0100, Luka Panio wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Luka Panio <lukapanio@gmail.com>
> 
> ---
> v2:
> Update commit message

What commit message?  I know I can't take patches without any changelog
text, maybe other maintainers are more loose?

thanks,

greg k-h
