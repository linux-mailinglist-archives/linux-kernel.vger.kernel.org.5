Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2A79D03E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjILLke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjILLkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:40:09 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2A118
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:39:46 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso1098882a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518785; x=1695123585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vA2HSelx8YKE/Mj0lvqWr/WE/7khz+4iMagyZZpskJNXE9+aotBFXOMaBnn0K/540e
         aZpRdzLYOC7q+qn+EFsg+EWcZkpl8C6ZfOMIfoe4zWYI58eWRstlROuc9ZTrGFfKd/5l
         NSjgL9q7aBIzkh2K3OpF1PJoq2peURjJj9FRXqikZUlBKwjkPzNfW08LddSR3QXQiHOj
         fhX5wOrb2f9snQAriTRQm4U2VrgLEReaIUYF+1WIVVjUUOaGxBxmFWWhLUPBQa2Wr4uT
         CrhSVdbR4WSRcJw4Prqj7Cn237P/2wZyqocTn7np7A6GRaOuIEqPCtrbmZBoKEP+MzSs
         Rm/A==
X-Gm-Message-State: AOJu0YySqac+j9DMF0RxiKVGa0Lo0fuEZmmzil/fvLrX1DnN5r+Vd1Lf
        qOFSYr2Pr5bTIScxIAnHMoIEL88Cesk=
X-Google-Smtp-Source: AGHT+IEt2gg+b0ELHrfLwF+UqY3w6g8ygIor5V06Lb7l0uqzIgKCfa/gXJ6u+YPzsZSKLSIj52eXrg==
X-Received: by 2002:a05:6402:42c5:b0:51e:34d8:f4c7 with SMTP id i5-20020a05640242c500b0051e34d8f4c7mr10382428edc.2.1694518784813;
        Tue, 12 Sep 2023 04:39:44 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7dace000000b005257da6be23sm5843018eds.75.2023.09.12.04.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:39:44 -0700 (PDT)
Message-ID: <8a47c824-ac32-6fa5-4898-892cb6fe6f3d@grimberg.me>
Date:   Tue, 12 Sep 2023 14:39:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        kbusch@kernel.org, hare@suse.de
References: <20230828212033.3244512-1-shiftee@posteo.net>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230828212033.3244512-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
