Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3A76EDC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbjHCPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbjHCPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:14:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAED30EA;
        Thu,  3 Aug 2023 08:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C97E61DFC;
        Thu,  3 Aug 2023 15:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03825C433C7;
        Thu,  3 Aug 2023 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075652;
        bh=AIs633hQWW4YEm39CMxIYiNnMQEracm5j/SVV+gbkn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LD13OYVzMeShG/qrZj8H0iyxP/cq5VhuaNq3iy65WB+6+aAKsR4kHaF6fOj9UhVLi
         QKneaR05jm41eefi3SY09QfFaQacxVFna1ugxw5lNNMi1Z22esoN/u4vnYx/OuEket
         mB/H7rODqdwLr3Hld3WeK8eBc8VxVuqxdbdx5JIdrp8wFBUCgfxiY4GBpeOjiiFFvc
         Frd1M34a2Owgh8DC1PZP2B4AZeaSCFl404SXoLZE0Lomv8VpycqmTrEk0rw2DJW8Nu
         ZyPN3HA8RHsYf5FZ13B6AIZSwggEYopMiXBvODopIzL08s2vdPZOalPJCO33572QjJ
         GbSK8Ln+kWlmQ==
Date:   Thu, 3 Aug 2023 08:17:14 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] lib/ucs2_string: Add UCS-2 strscpy function
Message-ID: <puep53etueo64phpx5zr2c76qfomk4qkd7kwxd6cqiuxcjbiyw@ukyuxcjdmdgn>
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-2-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730161906.606163-2-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 06:19:02PM +0200, Maximilian Luz wrote:
> Add a ucs2_strscpy() function for UCS-2 strings. The behavior is
> equivalent to the standard strscpy() function, just for 16-bit character
> UCS-2 strings.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
