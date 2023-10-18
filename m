Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF467CDB4A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjJRMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjJRMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:07:23 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCB113;
        Wed, 18 Oct 2023 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KhDy2uyh5BxLdB3QaglsiHAG0J7EpS+E3ZDPw2nSfPk=;
  b=Gn4JWz+/N8lQ1Em4gBQwaUbdOCp9AqZtorQwM7xfR/TvGiF5UrCboKgx
   B1gym28C59uvXeAg4ne3KBsjtoSmXvW4z3OMdDTASp4WAZSE+CbdRUvcB
   9wp1iUmzip38X+8ukGquaMpt5vuetGen+v5ZYMvjmrnT8c5baQy6H8Ke5
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,235,1694728800"; 
   d="scan'208";a="69068973"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 14:07:19 +0200
Date:   Wed, 18 Oct 2023 14:07:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org, andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove unused return values from functions
In-Reply-To: <cover.1697619623.git.anonolitunya@gmail.com>
Message-ID: <cb74515c-951c-f024-be3b-96e7e9bde068@inria.fr>
References: <cover.1697619623.git.anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Oct 2023, Dorcas AnonoLitunya wrote:

> Modifies the return type of different static functions to void as the return value is being ignored
> in all funtion calls thus not useful to have a return type.This improves
> code readability and maintainability.

Remember to put a space between a period and the start of the next
sentence.

julia

>
> Dorcas AnonoLitunya (2):
>   staging: sm750fb: Remove unused return value in
>     display_control_adjust_sm750le()
>   staging: sm750fb: Remove unused return value in
>     program_mode_registers()
>
>  drivers/staging/sm750fb/ddk750_mode.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> --
> 2.42.0.345.gaab89be2eb
>
>
>
