Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB492759B63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGSQt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGSQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:49:24 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C72127;
        Wed, 19 Jul 2023 09:49:09 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b89cfb4571so57036865ad.3;
        Wed, 19 Jul 2023 09:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785349; x=1692377349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaQnnXfA+u3adfYMdtW9tWio9fe6uzVE0UNesEG6pHs=;
        b=WWHEt552cntwrDhrWArDHWGSVb/4jlC4oXIIGYe+JUKauPn8n/1HpWuhAt4Q5SFq0h
         lsFuiZwRgdco/3K94gWpDNto9bcOkD0RvjwnVA+oFhY7JPnLhDtmpoJJTL0p1c+LvMwg
         4kwioB64qyCj/1S7Ry1LHrC6y+scLAOVOVhnarXDLsrjfrhfJa1aYShLZ8lH98vAYTvD
         HAaQSM8y3n0oPMkAnCi5M1/54G49d/5kZZBgZTOMGwuUQhnxYRLefit2OyhVcJFYf7IN
         iviFq0FT/ztsa6SzYMNBKO8bVSniwmyJ1X7xOivtwHxlPO8K8O1BGKE2HN4LQ4J7ycyd
         0D6Q==
X-Gm-Message-State: ABy/qLYK43I6mgvrnd3doC7to53yqcv6GGMf2+uh+zZXGWP/k5E2iz2R
        bsbMFhftL7xaRfRqq6Br7Sg=
X-Google-Smtp-Source: APBJJlGgsKFx+gSI337jIO3V/75MoqxZmb4ik8xsUfx6X1QRfZzp/1GByz+/aRgV2klSpx3bktXuBQ==
X-Received: by 2002:a17:902:ea0d:b0:1b0:6e16:b92c with SMTP id s13-20020a170902ea0d00b001b06e16b92cmr3343356plg.54.1689785349159;
        Wed, 19 Jul 2023 09:49:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a2ab:183f:c76c:d30d? ([2620:15c:211:201:a2ab:183f:c76c:d30d])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001b7fb1a8200sm4177403plc.258.2023.07.19.09.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 09:49:08 -0700 (PDT)
Message-ID: <bf2d41ce-2a56-adbb-d752-266fc5ed1128@acm.org>
Date:   Wed, 19 Jul 2023 09:49:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next] scsi: ufs: core: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20230712075836.15375-1-yang.lee@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230712075836.15375-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 00:58, Yang Li wrote:
> Use colons to separate parameter names from their specific meanings.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
