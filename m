Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15768764659
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjG0F5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjG0F5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:57:13 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE52D4B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:56:59 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99bc512526cso70832466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437417; x=1691042217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzOMzPLendpAU1YNxyKfxPOS8vnCK5yranAVrgYMJIo=;
        b=L9gNMVAiM3A3zRTfziOwmxtUpQi5KuyP5B/ODhFdlE8sC957RuRO0yJ01Wx/4Fc/uB
         F/uKDKgT28FXzb5jA++0nGKYmN5Dez0fxeh8gln/Y6o46Lent4daVeSnLlwHYv+sMpbN
         pPfzoUucnE3pMFC79aE/NqpzaOuPrObWHPzFVRxpUCRxqIbnlE0nMdY5CjMM4ncKmhFv
         ZI34fww6eK9qOQ4kMbRicO2dj0s7ZPT6wmr/59VGOk+34LfncwNDPPR71QCsd6VXHlMT
         KL/uR8Z9Le9AcJAwoxOmLtyu3lAI5rrkkeWO/ANcPV/W9karY+cz7vSitPqJqASSOZL+
         gFkg==
X-Gm-Message-State: ABy/qLZkOTk0dzESifNMTqgycfpP+O19+PYyOZ70JkXulyTvb94yACE1
        ADv5UGC+n83Yl5/qga8VX/8=
X-Google-Smtp-Source: APBJJlG4pb88s209LqM7FeGw9yEBFESj9HnWM+qgmqbjCW5/Hr66EK1rGzQmo6jRjzY02CN399m4Hg==
X-Received: by 2002:a17:906:5199:b0:99b:ca5d:1467 with SMTP id y25-20020a170906519900b0099bca5d1467mr1112205ejk.60.1690437417451;
        Wed, 26 Jul 2023 22:56:57 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id y6-20020a1709064b0600b00991bba473e2sm345482eju.85.2023.07.26.22.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:56:56 -0700 (PDT)
Message-ID: <f21dced8-b3c7-ffa2-5416-dc60c8909036@kernel.org>
Date:   Thu, 27 Jul 2023 07:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtQQVRDSCAxLzJdIHR0eTogdnQ6IEZpeCBz?=
 =?UTF-8?Q?pelling_typo_in_comment?=
Content-Language: en-US
To:     =?UTF-8?B?5qyn5LiW6ZuE?= <oushixiong@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ujr0l88uiz-ujtkgv2y6k@nsmail7.0.0--kylin--1>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <ujr0l88uiz-ujtkgv2y6k@nsmail7.0.0--kylin--1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 07. 23, 7:40, 欧世雄 wrote:
> Is there anything else I need to modify besides adding a changelog comments?

Hi,

drop the patch ;). "sane" is the correct word in here. Unlike "same".

thanks,
-- 
js
suse labs

