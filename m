Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347CD7A9050
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjIUBAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjIUBAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:00:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD5AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 18:00:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111C1C433C8;
        Thu, 21 Sep 2023 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695258032;
        bh=Z3g98CN97Kp2tDtu7HOQ22hDAtgJ3k/nNvIb2l3ASxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouayZvHri60qbbevVV/QKzbmdAaWutHLOCQwtgtjWqsGL+TgDginCgWDh1oCbFUwr
         +qgSS0dnA2NRzqj2NBpG8SQd0RPXUg2FEtVYfK8GZ1yyWW9e1qtU426ZiEI+uHIony
         UvQ13+EzeFDyTbfjXT00ftbrdgU7kHnL8us0yKzbzhrpGVMeLX4V9McRrrRxemCY9P
         Y7SXBuJ7BJkxtuS6zYNcLU2houNa2q66HkZpSBSfLqO2cJ6GfOYqb20jjIOdfBdXmq
         6Pq+EWwb9xwqijLAv5icVyLGa1WMnMc5LNaWLA36W24Vzty8K9rMQqDnOzMjr+0nHJ
         vOD9ij632GtEg==
Date:   Thu, 21 Sep 2023 08:48:17 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     =?utf-8?B?5rGq6L6w?= <wangchen20@iscas.ac.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        xiaoguang.xing@sophgo.com
Subject: Re: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042
 bindings
Message-ID: <ZQuS0ZE0Y6Lot/UM@xhacker>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
 <ec11eb6a-c37b-08bd-5997-8fc390fd58c8@linaro.org>
 <3d2bba58.29898.18ab279a15c.Coremail.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d2bba58.29898.18ab279a15c.Coremail.wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 08:03:50PM +0800, 汪辰 wrote:
> Sorry, my mistake to forget adding the tag, will add in next revision.

Hi Chen,

Soft remind: In mailist, top post should be avoided.

> 
> 
> &gt; -----原始邮件-----

And it looks like your email client is wrong, I dunno how your reply
looks in other people's email client, but it looks like html or
rich text in mutt.

> &gt; 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> &gt; 发送时间: 2023-09-20 19:55:30 (星期三)
> &gt; 收件人: "Chen Wang" <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org, emil.renner.berthing@canonical.com, guoren@kernel.org, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org, xiaoguang.xing@sophgo.com
> &gt; 抄送: "Chen Wang" <wangchen20@iscas.ac.cn>
> &gt; 主题: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042 bindings
> &gt; 
> &gt; On 20/09/2023 08:37, Chen Wang wrote:
> &gt; &gt; Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
> &gt; &gt; Milk-V Pioneer board [2].
> &gt; &gt; 
> &gt; &gt; [1]: https://en.sophgo.com/product/introduce/sg2042.html
> &gt; &gt; [2]: https://milkv.io/pioneer
> &gt; 
> &gt; This is a friendly reminder during the review process.
> &gt; 
> &gt; It looks like you received a tag and forgot to add it.
> &gt; 
> &gt; If you do not know the process, here is a short explanation:
> &gt; Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> &gt; versions, under or above your Signed-off-by tag. Tag is "received", when
> &gt; provided in a message replied to you on the mailing list. Tools like b4
> &gt; can help here. However, there's no need to repost patches *only* to add
> &gt; the tags. The upstream maintainer will do that for tags received on the
> &gt; version they apply.
> &gt; 
> &gt; https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> &gt; 
> &gt; If a tag was not added on purpose, please state why and what changed.
> &gt; 
> &gt; Best regards,
> &gt; Krzysztof
> 
> 
> ------------------------------
> 
> Best Regards 
>  
>  汪辰(Wang Chen) 
> 
> </wangchen20@iscas.ac.cn></unicornxw@gmail.com></krzysztof.kozlowski@linaro.org>
