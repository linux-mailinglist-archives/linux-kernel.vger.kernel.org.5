Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B07D1F7A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjJUUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJUUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:23:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C3119;
        Sat, 21 Oct 2023 13:23:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066ACC433C8;
        Sat, 21 Oct 2023 20:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697919781;
        bh=JF5Kry9cPoR465b2DzfRBGeglCdSJlHcQMOywBgtgrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sf786JB1uXeeDrqajMwEZPzQdk0ztDgyg+dwQ3tX0EVNKkZuv21UoXouvhXrM1j+Q
         qYDXsQPzOxbJU08EQqpTx78ngsLlvqD/r/MmfpYv3aYDzOFZqEAO8Ch+x1Yazars7G
         OKkwceMBibxjJievmv4VUQscHZDPSDcce9YGtp8c=
Date:   Sat, 21 Oct 2023 22:22:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     luka177 <lukapanio@gmail.com>
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
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6
 (xiaomi-pipa)
Message-ID: <2023102137-trio-lustrous-61e4@gregkh>
References: <20231021201840.210415-1-lukapanio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021201840.210415-1-lukapanio@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:18:39PM +0200, luka177 wrote:
> Add a compatible for Xiaomi Pad 6.
> 
> From: luka177 <lukapanio@gmail.com>
> 
> Signed-off-by: luka177 <lukapanio@gmail.com>
> 
> ---
> Add "From:" in commit message

That's not how that works, it needs to be the first line.  The
documentation states this, right?

And "177" shouldn't be in your name :)

thanks,

greg k-h
