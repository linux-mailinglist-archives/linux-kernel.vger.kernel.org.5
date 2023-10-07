Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB507BC9F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344170AbjJGVaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGVa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 17:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB393;
        Sat,  7 Oct 2023 14:30:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8909BC433C7;
        Sat,  7 Oct 2023 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696714226;
        bh=Asz0kAidCXdNyyjv78EuXEU55dPMW7DudgwPSZhas6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwD0qETWEV32uLd4myrJ5IuHQOxSxdlVbVAZFGkf/rc4k32PZ+RIsXJvFVsj36EDd
         vjtq9t4jCqIDAKZdQbSCkQJze33sKcrTtUBqTcLJV4oivoEJFtZnHQ+o5P8vsbLzbW
         bHjwP7XGKXEk8CzQIJYtpPnNAxfFDNbVqwwh7/AlbhhTvlOMyhleZHeQ+9mB/SXedl
         KXGNBdAkdp80l9X7BDsdyszpoYALJerhjrZHNRFhGXEKmYHLC+vH27r5Mk9/VTCFoi
         PcRPf1Iy/Cd+zp77R+W7UiHm9zArFB1JoAddHzobd7LhhXeRGZspOO3ibPs66h8aKX
         pMl3gz0i6ILEg==
Date:   Sat, 7 Oct 2023 14:30:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     He-Jie Shih <bignose1007@gmail.com>
Cc:     Charlie Jenkins <charlie@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20231007213023.GB174883@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain>
 <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
 <7BC51820-61BC-422C-A2F7-B68CE679972C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7BC51820-61BC-422C-A2F7-B68CE679972C@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 05:01:45AM +0800, He-Jie Shih wrote:
> Reply-To: 20231006194741.GA68531@google.com
> X-Mailer: Apple Mail (2.3445.9.7)

Can you please fix your email client configuration?  Your emails have a bogus
Reply-To header, which makes replies not be sent to you by default.

- Eric
