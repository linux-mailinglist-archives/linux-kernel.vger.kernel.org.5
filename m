Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB3E7E7130
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbjKISHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbjKISHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:07:20 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DD6CE;
        Thu,  9 Nov 2023 10:07:18 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6c4b06af98bso885476b3a.2;
        Thu, 09 Nov 2023 10:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553238; x=1700158038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NasWvcRBpTONaUSAIbJgSFZERWGFjmTmU97ZZYS9Vk=;
        b=pMvAava4BWqu1wfCHTd811BPziuU7mgfHgV5wRWWeRqkwfvmqzGRnN1tmPH6kwhYk9
         f9B9glBvviatzRTqLHHz8N13c87B5NGZZjWZTRbdL/3s11gNYvsujhzYkIT12opY6g5M
         OwVVbb0l4dhoDr/RpZ/hfi159TVxOja/e+U6F4V0/t+eq0F2xNo+S44ilPMn+uYocM0+
         Ew/jBHIDgTptSJVWHPmDWZma53r0t0BCDD7/WzxEKqR9V8ziBvnAOI+Dus7HxGV93t5l
         P99kBMHWUi1yWOOSWh5Ux2gRKzJ+s6DqdUv0YryTdpYr+ID2kzoI4FiUvtfC1Ob2Vzys
         JJTg==
X-Gm-Message-State: AOJu0YzUVeBpHm/to8/DjbqCASmQSK74a+1+9auNR3jmzU77FVYLf5HK
        EvsaIAqLqHIzsus5LFjg5Wc=
X-Google-Smtp-Source: AGHT+IGtw+Qy6lx2q0BXlU/BTq87k5XpZlYukLNdOZwlwlZLmm/rSyNZrtAFVF4EcWlKFADYGX9RZA==
X-Received: by 2002:a05:6a00:985:b0:6bf:5131:884a with SMTP id u5-20020a056a00098500b006bf5131884amr5784048pfg.6.1699553238034;
        Thu, 09 Nov 2023 10:07:18 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3dcd:f87f:1890:c48e? ([2620:0:1000:8411:3dcd:f87f:1890:c48e])
        by smtp.gmail.com with ESMTPSA id ff24-20020a056a002f5800b0069337938be8sm10932129pfb.110.2023.11.09.10.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 10:07:17 -0800 (PST)
Message-ID: <dd366eae-43ca-4091-bcfc-4c109273c7c5@acm.org>
Date:   Thu, 9 Nov 2023 10:07:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Add UFS RTC support
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        mani@kernel.org, quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
References: <20231109125217.185462-1-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231109125217.185462-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 04:52, Bean Huo wrote:
> *** BLURB HERE ***

Please include a description of the patch series in the cover letter.

Thanks,

Bart.

