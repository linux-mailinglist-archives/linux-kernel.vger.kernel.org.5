Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A23D7627C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 02:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGZAad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 20:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGZAab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC010FD;
        Tue, 25 Jul 2023 17:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD29B619BA;
        Wed, 26 Jul 2023 00:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A5BC433C8;
        Wed, 26 Jul 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690331430;
        bh=4szL2Sg9ae4unN4oGxbDpSM5eGaBOgEsadtOIA9oSTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5s/DZCrImd9xEqYfGI9efZ0UQeuoXJMqNqVH/HD+lbalPV6cihIQJoCvOmYW/H2G
         PVfCA+5PorNlLcBuFLJQ0axNoUy0GNeYoGtV0EHvbC2RilvuPcauznuQZJGWTCj8cV
         SUdmfNWu2kW9bxsJmk6UTRr4HhUxtyb51D+aNQydojwKNTqphBdLt7j+gIUo058m9K
         KXMsRe5ZM0yMlCK1hC6zuJOR50TH+pbCg+eol7YGK9TN3eqSVtAmtiexbYnV9EjXbh
         ELcy67AQrgiCZbT6uPdJGW0uFUbldpRMtSoNahJlfIi14u+8wwBJgBW9XOhj46S8Q7
         zJWoNLMfmAPKg==
Date:   Wed, 26 Jul 2023 08:18:50 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: add reviewer for T-Head RISC-V SoC
 support
Message-ID: <ZMBmalZwaRCiy2BG@xhacker>
References: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v2-3-a470ab8fe806@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v2-3-a470ab8fe806@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:20:40AM -0700, Drew Fustini wrote:
> I will maintain support for the TH1520-based BeagleV Ahead board so
> adding myself as a reviewer for T-Head SoC patches.

Hi Drew,

Thanks for your interest in maintaining the SoC support part. However,
maintainership involves active reviewing and maintaining the whole SoC
support part and not just specific board part, although currently, the
SoC support in mainline is minimal. I'd like to see your patch
reviewing, testing and so on.

Thanks
> 
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d516295978a4..eaec3333f2ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18326,6 +18326,7 @@ RISC-V THEAD SoC SUPPORT
>  M:	Jisheng Zhang <jszhang@kernel.org>
>  M:	Guo Ren <guoren@kernel.org>
>  M:	Fu Wei <wefu@redhat.com>
> +R:	Drew Fustini <dfustini@baylibre.com>
>  L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  F:	arch/riscv/boot/dts/thead/
> 
> -- 
> 2.34.1
> 
