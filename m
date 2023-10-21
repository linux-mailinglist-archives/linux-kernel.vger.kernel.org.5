Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29CC7D1F37
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 21:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjJUT76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 15:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUT75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 15:59:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11931A3;
        Sat, 21 Oct 2023 12:59:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3448C433C8;
        Sat, 21 Oct 2023 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697918392;
        bh=xfkUHsOxxlTRzwO2mYq/zSnnqro/eqkufhUkFk+s28U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXwBQFpXhp/qt1n4kb+0nQmUgiLhuRg+FE7mjybK/3Ct1MQuYFZZjcu5iWBOWW1Bp
         bJgeZDOf2bjbZLRkeAPm1V5I6X216jcbG66rA5+B5Wm/fz6JbXkvlAQ1faMf4+tlrI
         KoF6C1mjGvh8Czaqtq8EgT14c3qgRrFwfm3WbMQw=
Date:   Sat, 21 Oct 2023 21:59:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0JvRg9C60LAg0J/QsNC90YzQvg==?= <lukapanio@gmail.com>
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
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree
Message-ID: <2023102135-work-mutate-a76f@gregkh>
References: <20231021173317.185460-1-lukapanio@gmail.com>
 <20231021173317.185460-2-lukapanio@gmail.com>
 <2023102127-bash-stool-95a8@gregkh>
 <CACi=Ov4gdRwhEAo6Qm5EgQucx-1UZXXMHpA21OUDhNHEmmCJNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACi=Ov4gdRwhEAo6Qm5EgQucx-1UZXXMHpA21OUDhNHEmmCJNA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 09:37:16PM +0200, Лука Паньо wrote:
> This is a new version, but there is no change for dt-bindings part.

Then you must document this.

> As for
> "From:" submitting-patches.rst: "Note, the From: tag is optional when the
> From: author is also the person (and
> email) listed in the From: line of the email header."

Your patch had numbers in the name, but not here, so please use what you
have used here in this email, "Лука Паньо" and you should be fine,
right?

thanks,

greg k-h
